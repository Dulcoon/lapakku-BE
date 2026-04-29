<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use App\Models\Product;
use App\Models\ProductVariant;
use Illuminate\Support\Str;

class ProductVariantSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $products = Product::all();

        foreach ($products as $product) {
            ProductVariant::create([
                'id' => Str::uuid(),
                'product_id' => $product->id,
                'sku' => strtoupper(Str::slug($product->name)) . '-001',
                'price' => 50000,
                'stock' => 100,
                'weight_gram' => 200,
            ]);
        }
    }
}
