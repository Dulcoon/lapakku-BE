<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProductResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        $variant = $this->variants->first();

        return [
            'id' => $this->id,
            'name' => $this->name,
            'slug' => $this->slug,

            'price' => $variant?->price,
            'stock' => $variant?->stock,

            'image' => $this->images->where('is_primary', true)->first()?->url,

            'category' => [
                'id' => $this->category->id,
                'name' => $this->category->name,
            ],

            'variants' => $this->variants->map(function($v) {
                return [
                    'id' => $v->id,
                    'sku' => $v->sku,
                    'price' => $v->price,
                    'stock' => $v->stock,
                ];
            }),
        ];
    }
}