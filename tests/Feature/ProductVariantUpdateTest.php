<?php

namespace Tests\Feature;

use App\Models\Category;
use App\Models\Product;
use App\Models\ProductVariant;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ProductVariantUpdateTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        if (!extension_loaded('pdo_sqlite')) {
            $this->markTestSkipped('pdo_sqlite extension is required to run this test.');
        }

        parent::setUp();
    }

    public function test_update_enable_variants_preserves_existing_stock_when_variant_stock_missing()
    {
        $user = User::factory()->create();
        $token = $user->createToken('test')->plainTextToken;

        $category = Category::factory()->create();
        $product = Product::factory()->create(['category_id' => $category->id]);

        ProductVariant::create([
            'product_id' => $product->id,
            'sku' => 'BASE-001',
            'price' => 100000,
            'stock' => 12,
            'weight_gram' => 200,
        ]);

        $payload = [
            'name' => 'Updated Product',
            'category_id' => $category->id,
            'price' => 100000,
            'stock' => 12,
            'description' => 'Updated description',
            'has_variants' => '1',
            'options' => json_encode([
                ['name' => 'Size', 'values' => ['S', 'M', 'L']],
            ]),
            'variants' => json_encode([
                ['name' => 'S', 'sku' => '', 'price' => '', 'stock' => '', 'option_values' => ['Size' => 'S']],
                ['name' => 'M', 'sku' => '', 'price' => '', 'stock' => '', 'option_values' => ['Size' => 'M']],
                ['name' => 'L', 'sku' => '', 'price' => '', 'stock' => '', 'option_values' => ['Size' => 'L']],
            ]),
        ];

        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->putJson('/api/v1/products/' . $product->id, $payload);

        $response->assertStatus(200);
        $response->assertJsonPath('data.stock', 12);
        $response->assertJsonPath('data.price', 100000);
        $this->assertCount(3, $response->json('data.variants'));
    }
}
