<?php
use App\Models\User;
use App\Models\ProductVariant;
use Illuminate\Http\Request;
use App\Http\Controllers\Api\V1\CartController;
use App\Http\Controllers\Api\V1\OrderController;
use Illuminate\Support\Facades\DB;

try {
    DB::beginTransaction();

    // 1. Get a user and a variant
    $user = User::where('role', 'customer')->first();
    if (!$user) {
        throw new Exception("No customer user found.");
    }
    
    $variant = ProductVariant::first();
    if (!$variant) {
        throw new Exception("No product variant found.");
    }

    echo "User: {$user->email}\n";
    echo "Variant: {$variant->id}\n";

    // 2. Test Add to Cart
    $request = Request::create('/api/v1/cart/add', 'POST', [
        'variant_id' => $variant->id,
        'quantity' => 2,
    ]);
    $request->setUserResolver(function () use ($user) { return $user; });
    
    $cartController = new CartController();
    $addResponse = $cartController->add($request);
    echo "Add to Cart Response: " . $addResponse->getContent() . "\n";

    // 3. Test Get Cart
    $request = Request::create('/api/v1/cart', 'GET');
    $request->setUserResolver(function () use ($user) { return $user; });
    
    $getCartResponse = $cartController->index($request);
    $cartData = json_decode($getCartResponse->getContent(), true);
    echo "Cart Items Count: " . count($cartData['items']) . "\n";

    // 4. Test Checkout
    $request = Request::create('/api/v1/checkout', 'POST');
    $request->setUserResolver(function () use ($user) { return $user; });
    
    $orderController = new OrderController();
    $checkoutResponse = $orderController->checkout($request);
    echo "Checkout Response: " . $checkoutResponse->getContent() . "\n";

    DB::rollBack();
    echo "FLOW SUCCESS\n";
} catch (\Exception $e) {
    DB::rollBack();
    echo "ERROR: " . $e->getMessage() . "\n";
    echo $e->getTraceAsString();
}
