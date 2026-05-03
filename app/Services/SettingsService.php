<?php

namespace App\Services;

use App\Models\SiteSetting;
use Illuminate\Support\Facades\Cache;

class SettingsService
{
    private static ?array $cache = null;

    public static function get(string $key, $default = null)
    {
        self::loadCache();

        return self::$cache[$key] ?? $default;
    }

    public static function all(): array
    {
        self::loadCache();

        return self::$cache ?? [];
    }

    public static function set(string $key, $value, bool $encrypted = false): void
    {
        SiteSetting::updateOrCreate(
            ['key' => $key],
            [
                'value' => $encrypted ? encrypt($value) : $value,
                'is_encrypted' => $encrypted,
            ]
        );

        self::clearCache();
    }

    public static function loadCache(): void
    {
        if (self::$cache !== null) {
            return;
        }

        self::$cache = [];

        $settings = SiteSetting::all();

        foreach ($settings as $setting) {
            $value = $setting->is_encrypted
                ? decrypt($setting->value)
                : $setting->value;
            self::$cache[$setting->key] = $value;
        }
    }

    public static function clearCache(): void
    {
        self::$cache = null;
        Cache::forget('site_settings');
    }
}
