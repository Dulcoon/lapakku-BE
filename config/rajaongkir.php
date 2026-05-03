<?php

return [
    'api_key' => env('RAJAONGKIR_API_KEY'),
    'is_production' => env('RAJAONGKIR_IS_PRODUCTION', false),

    'couriers' => [
        'jne' => 'JNE',
        'jnt' => 'J&T Express',
        'pos' => 'Pos Indonesia',
        'tiki' => 'TIKI',
        'wahana' => 'Wahana',
        'sicepat' => 'SiCepat',
        'anteraja' => 'AnterAja',
        'ninja' => 'Ninja Express',
        'lion' => 'Lion Parcel',
        'rex' => 'REX Express',
    ],
];