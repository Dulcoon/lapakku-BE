<?php

namespace App\Http\Controllers\Api\V1;

use App\Models\UserAddress;
use App\Services\RajaongkirService;
use App\Services\SettingsService;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Log;

class ShippingController extends Controller
{
    private RajaongkirService $rajaongkir;

    public function __construct()
    {
        $this->rajaongkir = new RajaongkirService();
    }

    public function getShippingCosts(Request $request)
    {
        $request->validate([
            'address_id' => 'required|uuid|exists:user_addresses,id',
            'weight' => 'required|integer|min:1',
        ]);

        $address = UserAddress::where('user_id', $request->user()->id)
            ->findOrFail($request->address_id);

        if (!$address->city) {
            return response()->json([
                'message' => 'Alamat belum memiliki kota. Silakan lengkapi alamat terlebih dahulu.',
            ], 400);
        }

        $originSetting = SettingsService::get('shipping_origin_city') ?: config('app.shipping_origin_city') ?: '501';
        // If stored as "id:name", extract the ID
        $originId = null;
        $originCity = $originSetting;
        if (str_contains($originSetting, ':')) {
            $parts = explode(':', $originSetting, 2);
            $originId = $parts[0];
            $originCity = $parts[1] ?? '';
        }

        $couriers = RajaongkirService::couriers();
        
        $results = [];
        
        foreach (array_keys($couriers) as $courier) {
            try {
                $costResults = $this->rajaongkir->getShippingCost(
                    $originCity,
                    $address->city,
                    $request->weight,
                    $courier,
                    $originId,
                    $address->city_id
                );

                foreach ($costResults as $cost) {
                    $results[] = [
                        'courier_code' => strtolower($cost['code'] ?? $courier),
                        'courier_name' => $cost['name'] ?? ($couriers[$courier] ?? $courier),
                        'service' => $cost['service'] ?? '',
                        'description' => $cost['description'] ?? '',
                        'cost' => $cost['cost'] ?? 0,
                        'etd' => $cost['etd'] ?? '',
                    ];
                }
            } catch (\Exception $e) {
                Log::error("Rajaongkir shipping cost error for courier $courier: " . $e->getMessage());
            }
        }

        $results = array_filter($results, fn($r) => $r['cost'] > 0);
        usort($results, fn($a, $b) => $a['cost'] <=> $b['cost']);

        if (empty($results)) {
            $fallbackOptions = $this->getFallbackShipping($request->weight);
            return response()->json([
                'address' => [
                    'id' => $address->id,
                    'label' => $address->label,
                    'city' => $address->city,
                ],
                'shipping_options' => $fallbackOptions,
                'is_fallback' => true,
            ]);
        }

        return response()->json([
            'address' => [
                'id' => $address->id,
                'label' => $address->label,
                'city' => $address->city,
            ],
            'shipping_options' => $results,
        ]);
    }

    private function getFallbackShipping(int $weight): array
    {
        $weightKg = max(1, (int) ceil($weight / 1000));
        
        return [
            [
                'courier_code' => 'jne',
                'courier_name' => 'JNE',
                'service' => 'REG',
                'description' => 'Layanan Regular',
                'cost' => 15000 + (($weightKg - 1) * 5000),
                'etd' => '3-5 hari',
            ],
            [
                'courier_code' => 'jne',
                'courier_name' => 'JNE',
                'service' => 'YES',
                'description' => 'Yakin Esok',
                'cost' => 25000 + (($weightKg - 1) * 5000),
                'etd' => '1 hari',
            ],
            [
                'courier_code' => 'sicepat',
                'courier_name' => 'SiCepat',
                'service' => 'REG',
                'description' => 'Layanan Regular',
                'cost' => 13000 + (($weightKg - 1) * 4000),
                'etd' => '2-4 hari',
            ],
            [
                'courier_code' => 'anteraja',
                'courier_name' => 'AnterAja',
                'service' => 'REG',
                'description' => 'Layanan Regular',
                'cost' => 12000 + (($weightKg - 1) * 3500),
                'etd' => '2-3 hari',
            ],
        ];
    }

    public function getTracking(Request $request)
    {
        $request->validate([
            'order_id' => 'required|uuid|exists:orders,id',
        ]);

        $order = $request->user()->orders()->findOrFail($request->order_id);

        if (!$order->tracking_number || !$order->courier_code) {
            return response()->json([
                'message' => 'Nomor tracking belum tersedia',
            ], 400);
        }

        $tracking = $this->rajaongkir->getTracking(
            $order->tracking_number,
            $order->courier_code
        );

        if (!$tracking) {
            return response()->json([
                'message' => 'Tidak dapat mengambil data tracking',
            ], 400);
        }

        return response()->json([
            'order_number' => $order->order_number,
            'courier_code' => $order->courier_code,
            'courier_service' => $order->courier_service,
            'tracking_number' => $order->tracking_number,
            'status' => $tracking['status'] ?? null,
            'history' => $tracking['history'] ?? [],
        ]);
    }

    public function searchCities(Request $request)
    {
        $request->validate([
            'search' => 'required|string|min:2',
        ]);

        $results = $this->rajaongkir->searchDestination($request->search);

        return response()->json([
            'cities' => array_map(function ($city) {
                return [
                    'id' => $city['id'] ?? null,
                    'label' => $city['label'] ?? '',
                    'city_name' => $city['city_name'] ?? '',
                    'province' => $city['province_name'] ?? '',
                    'district' => $city['district_name'] ?? '',
                    'subdistrict' => $city['subdistrict_name'] ?? '',
                    'postal_code' => $city['zip_code'] ?? '',
                ];
            }, $results),
        ]);
    }

    public function couriers()
    {
        return response()->json([
            'couriers' => RajaongkirService::couriers(),
        ]);
    }
}