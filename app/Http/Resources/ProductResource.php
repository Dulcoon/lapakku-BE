<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProductResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        $variants = $this->variants;
        $minPrice = $variants->min('price');
        $maxPrice = $variants->max('price');
        $totalStock = $variants->sum('stock');

        $galleryImages = $this->images
            ->whereNull('variant_id')
            ->sortBy('sort_order')
            ->values();

        $primaryImage = $galleryImages->firstWhere('is_primary') ?? $galleryImages->first();

        $formatImageUrl = function (?string $url): ?string {
            if (!$url) return null;
            if (str_starts_with($url, 'http')) return $url;
            return asset('storage/' . $url);
        };

        return [
            'id' => $this->id,
            'name' => $this->name,
            'slug' => $this->slug,
            'description' => $this->description,
            'category_id' => $this->category_id,
            'has_variants' => $this->variants->count() > 1 || ($this->variants->count() === 1 && $this->variants->first()->attributeValues->count() > 0),

            'price' => $minPrice,
            'price_range' => [
                'min' => $minPrice,
                'max' => $maxPrice,
                'is_variable' => $minPrice !== $maxPrice
            ],
            'stock' => $totalStock,

            'image' => $formatImageUrl($primaryImage?->url),

            'images' => $galleryImages->map(fn($img) => [
                'id' => $img->id,
                'url' => $formatImageUrl($img->url),
                'is_primary' => $img->is_primary,
                'sort_order' => $img->sort_order,
            ])->values(),

            'category' => [
                'id' => $this->category->id,
                'name' => $this->category->name,
            ],

            'variants' => $this->variants->map(function ($v) use ($formatImageUrl) {
                return [
                    'id' => $v->id,
                    'sku' => $v->sku,
                    'price' => $v->price,
                    'stock' => $v->stock,
                    'images' => $v->images->sortBy('sort_order')->map(fn($img) => [
                        'id' => $img->id,
                        'url' => $formatImageUrl($img->url),
                    ])->values(),
                    'attribute_values' => $v->attributeValues->map(function ($av) {
                        return [
                            'id' => $av->id,
                            'value' => $av->value,
                            'attribute' => [
                                'id' => $av->attribute->id,
                                'name' => $av->attribute->name,
                            ]
                        ];
                    }),
                ];
            }),
        ];
    }
}
