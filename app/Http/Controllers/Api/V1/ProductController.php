<?php

namespace App\Http\Controllers\Api\V1;

use App\Models\Product;
use App\Http\Controllers\Controller;
use App\Http\Resources\ProductResource;

class ProductController extends Controller
{
    public function index()
    {
        $products = Product::query()
            ->with([
                'variants',
                'images',
                'category'
            ])
            ->where('status', 'active')
            ->latest()
            ->paginate(10);

        return ProductResource::collection($products);
    }

    public function show($slug)
    {
        $product = Product::query()
            ->with([
                'variants',
                'images',
                'category'
            ])
            ->where('slug', $slug)
            ->where('status', 'active')
            ->firstOrFail();

        return new ProductResource($product);
    }
}
