<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class RajaongkirService
{
    private string $baseUrl;
    private string $apiKey;

    public function __construct()
    {
        $this->apiKey = SettingsService::get('rajaongkir_api_key') ?? config('rajaongkir.api_key') ?? env('RAJAONGKIR_API_KEY');
        $this->baseUrl = 'https://rajaongkir.komerce.id/api/v1/';
    }

    private function httpClient()
    {
        return Http::withHeaders([
            'key' => $this->apiKey,
        ])->timeout(30)->connectTimeout(15);
    }

    public function searchDestination(string $query = '')
    {
        try {
            $response = $this->httpClient()->get($this->baseUrl . 'destination/domestic-destination', [
                'search' => $query,
                'limit' => 10,
            ]);

            $data = $response->json();
            
            if (isset($data['meta']['code']) && $data['meta']['code'] === 200) {
                return $data['data'] ?? [];
            }
            
            Log::warning('Rajaongkir searchDestination failed: ' . ($data['meta']['message'] ?? 'Unknown'));
            return [];
        } catch (\Exception $e) {
            Log::error('Rajaongkir searchDestination error: ' . $e->getMessage());
            return [];
        }
    }

    public function getCityIdByName(string $cityName)
    {
        $searches = [
            $cityName,
            preg_replace('/\s+Regency$/i', '', $cityName),
            preg_replace('/(Regency|Kabupaten|Kab\.\s*)/i', '', $cityName),
            preg_replace('/\s*\(.*\)/', '', $cityName),
            trim($cityName),
        ];
        
        $searches = array_unique(array_filter($searches));
        
        foreach ($searches as $search) {
            if (empty($search)) continue;
            
            $results = $this->searchDestination($search);
            if (!empty($results)) {
                return $results[0]['id'] ?? null;
            }
        }

        return null;
    }

    public function getShippingCost(string $origin, string $destination, int $weight, string $courier)
    {
        try {
            // Validate origin and destination are not empty
            if (empty(trim($origin))) {
                Log::warning('Rajaongkir: Origin is empty');
                return [];
            }

            if (empty(trim($destination))) {
                Log::warning('Rajaongkir: Destination is empty');
                return [];
            }

            $originId = $this->getCityIdByName($origin);
            if (!$originId) {
                Log::warning('Rajaongkir: Origin not found for: ' . $origin);
                return [];
            }

            $destinationId = $this->getCityIdByName($destination);
            if (!$destinationId) {
                Log::warning('Rajaongkir: Destination not found for: ' . $destination);
                return [];
            }

            $response = $this->httpClient()->post($this->baseUrl . 'calculate/domestic-cost', [
                'origin' => $originId,
                'destination' => $destinationId,
                'weight' => $weight,
                'courier' => $courier,
            ]);

            $data = $response->json();

            if (isset($data['meta']['code']) && $data['meta']['code'] === 200) {
                return $data['data'] ?? [];
            }

            Log::warning('Rajaongkir calculate error: ' . ($data['meta']['message'] ?? 'Unknown error'));
            return [];
        } catch (\Exception $e) {
            Log::error('Rajaongkir getShippingCost error: ' . $e->getMessage());
            return [];
        }
    }

    public function getTracking(string $waybill, string $courier)
    {
        try {
            $response = $this->httpClient()->post($this->baseUrl . 'tracking', [
                'waybill' => $waybill,
                'courier' => $courier,
            ]);

            $data = $response->json();
            return $data['data'] ?? null;
        } catch (\Exception $e) {
            Log::error('Rajaongkir getTracking error: ' . $e->getMessage());
            return null;
        }
    }

    public static function couriers(): array
    {
        return config('rajaongkir.couriers', [
            'jne' => 'JNE',
            'jnt' => 'J&T Express',
            'pos' => 'Pos Indonesia',
            'tiki' => 'TIKI',
            'wahana' => 'Wahana',
            'sicepat' => 'SiCepat',
            'anteraja' => 'AnterAja',
            'ninja' => 'Ninja Express',
        ]);
    }
}