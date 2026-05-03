<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Services\SettingsService;
use Illuminate\Http\Request;

class SettingController extends Controller
{
    public function index()
    {
        $settings = SettingsService::all();

        $keys = [
            'midtrans_server_key',
            'midtrans_client_key',
            'midtrans_is_production',
            'rajaongkir_api_key',
            'rajaongkir_is_production',
            'shipping_origin_city',
        ];

        $data = [];
        foreach ($keys as $key) {
            $value = $settings[$key] ?? null;
            $data[$key] = $value ?? '';
        }

        return response()->json(['settings' => $data]);
    }

    public function update(Request $request)
    {
        $request->validate([
            'midtrans_server_key' => 'nullable|string',
            'midtrans_client_key' => 'nullable|string',
            'midtrans_is_production' => 'nullable|boolean',
            'rajaongkir_api_key' => 'nullable|string',
            'rajaongkir_is_production' => 'nullable|boolean',
            'shipping_origin_city' => 'nullable|string',
        ]);

        $fields = [
            'midtrans_server_key' => true,
            'midtrans_client_key' => true,
            'rajaongkir_api_key' => true,
        ];

        $nonEncrypted = [
            'midtrans_is_production',
            'rajaongkir_is_production',
            'shipping_origin_city',
        ];

        foreach ($fields as $key => $encrypted) {
            if ($request->has($key) && $request->input($key) !== null) {
                SettingsService::set($key, $request->input($key), $encrypted);
            }
        }

        foreach ($nonEncrypted as $key) {
            if ($request->has($key)) {
                SettingsService::set($key, $request->input($key), false);
            }
        }

        return response()->json(['message' => 'Settings saved successfully']);
    }
}
