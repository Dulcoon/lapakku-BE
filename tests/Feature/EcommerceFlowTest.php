<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;
use App\Models\User;
use App\Models\Category;
use App\Models\Product;
use App\Models\ProductVariant;

class EcommerceFlowTest extends TestCase
{
    use RefreshDatabase;

    public function test_full_ecommerce_api_flow()
    {
        // 1. Setup minimal data
        $category = Category::factory()->create();
        $product = Product::factory()->create(['category_id' => $category->id]);
        $variant = ProductVariant::create([
            'product_id' => $product->id,
            'sku' => 'TEST-001',
            'price' => 50000,
            'stock' => 10,
            'weight_gram' => 200,
        ]);

        // 2. Register
        $response = $this->postJson('/api/auth/register', [
            'name' => 'John Doe',
            'email' => 'john@example.com',
            'password' => 'password',
            'password_confirmation' => 'password',
        ]);
        $response->assertStatus(200)->assertJsonStructure(['access_token']);
        $token = $response->json('access_token');

        // 3. Browse Products
        $response = $this->getJson('/api/v1/products');
        $response->assertStatus(200);
        $this->assertGreaterThan(0, count($response->json('data')));

        $response = $this->getJson('/api/v1/products/' . $product->slug);
        $response->assertStatus(200)->assertJsonFragment(['slug' => $product->slug]);

        // 4. Add to Cart
        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->postJson('/api/v1/cart/add', [
            'variant_id' => $variant->id,
            'quantity' => 2,
        ]);
        $response->assertStatus(200);

        // 5. Get Cart
        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->getJson('/api/v1/cart');
        $response->assertStatus(200);
        $this->assertEquals(1, count($response->json('items')));
        $this->assertEquals(2, $response->json('items.0.quantity'));

        // 6. Checkout
        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->postJson('/api/v1/checkout');
        $response->assertStatus(200)->assertJsonStructure(['message', 'order_id']);

        // 7. Get Orders
        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->getJson('/api/v1/orders');
        $response->assertStatus(200);
        $this->assertEquals(1, count($response->json()));
        $this->assertEquals(110000, $response->json('0.grand_total')); // (50k * 2) + 10k shipping
    }
}
