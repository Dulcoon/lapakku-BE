<?php
use App\Http\Controllers\Api\Auth\AuthController;
use App\Http\Controllers\Api\V1\ProductController;
use Illuminate\Support\Facades\Route;

Route::prefix('auth')->group(function () {
    Route::post('/register', [AuthController::class, 'register']);
    Route::post('/login', [AuthController::class, 'login']);

    Route::middleware('auth:sanctum')->group(function () {
        Route::get('/me', [AuthController::class, 'me']);
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::post('/logout-all', [AuthController::class, 'logoutAll']);
    });
});

Route::prefix('v1')->group(function () {
    Route::get('/products', [ProductController::class, 'index']);
    Route::get('/products/{slug}', [ProductController::class, 'show']);
    Route::get('/categories', [\App\Http\Controllers\Api\V1\CategoryController::class, 'index']);
    Route::get('/banners', [\App\Http\Controllers\Api\V1\BannerController::class, 'active']);

    Route::middleware('auth:sanctum')->group(function () {
        // Categories Management (Admin)
        Route::post('/categories', [\App\Http\Controllers\Api\V1\CategoryController::class, 'store']);
        Route::put('/categories/{id}', [\App\Http\Controllers\Api\V1\CategoryController::class, 'update']);
        Route::delete('/categories/{id}', [\App\Http\Controllers\Api\V1\CategoryController::class, 'destroy']);

        // Products Management (Admin)
        Route::post('/products', [ProductController::class, 'store']);
        Route::put('/products/{id}', [ProductController::class, 'update']);
        Route::delete('/products/{id}', [ProductController::class, 'destroy']);

        // Banners Management (Admin)
        Route::get('/admin/banners', [\App\Http\Controllers\Api\V1\BannerController::class, 'index']);
        Route::post('/admin/banners', [\App\Http\Controllers\Api\V1\BannerController::class, 'store']);
        Route::put('/admin/banners/{id}', [\App\Http\Controllers\Api\V1\BannerController::class, 'update']);
        Route::delete('/admin/banners/{id}', [\App\Http\Controllers\Api\V1\BannerController::class, 'destroy']);
        Route::post('/admin/banners/reorder', [\App\Http\Controllers\Api\V1\BannerController::class, 'reorder']);

        // Cart API
        Route::get('/cart', [\App\Http\Controllers\Api\V1\CartController::class, 'index']);
        Route::post('/cart/add', [\App\Http\Controllers\Api\V1\CartController::class, 'add']);
        Route::put('/cart/item/{id}', [\App\Http\Controllers\Api\V1\CartController::class, 'update']);
        Route::delete('/cart/item/{id}', [\App\Http\Controllers\Api\V1\CartController::class, 'remove']);

        // Addresses
        Route::get('/addresses', [\App\Http\Controllers\Api\V1\AddressController::class, 'index']);
        Route::post('/addresses', [\App\Http\Controllers\Api\V1\AddressController::class, 'store']);
        Route::get('/addresses/{id}', [\App\Http\Controllers\Api\V1\AddressController::class, 'show']);
        Route::put('/addresses/{id}', [\App\Http\Controllers\Api\V1\AddressController::class, 'update']);
        Route::delete('/addresses/{id}', [\App\Http\Controllers\Api\V1\AddressController::class, 'destroy']);
        Route::post('/addresses/{id}/set-default', [\App\Http\Controllers\Api\V1\AddressController::class, 'setDefault']);

        // Shipping
        Route::get('/shipping/cities', [\App\Http\Controllers\Api\V1\ShippingController::class, 'searchCities']);
        Route::get('/shipping/couriers', [\App\Http\Controllers\Api\V1\ShippingController::class, 'couriers']);
        Route::post('/shipping/cost', [\App\Http\Controllers\Api\V1\ShippingController::class, 'getShippingCosts']);
        Route::post('/shipping/tracking', [\App\Http\Controllers\Api\V1\ShippingController::class, 'getTracking']);

        // Checkout & Orders
        Route::post('/checkout', [\App\Http\Controllers\Api\V1\OrderController::class, 'checkout']);
        Route::get('/orders', [\App\Http\Controllers\Api\V1\OrderController::class, 'orders']);
        Route::get('/orders/{id}', [\App\Http\Controllers\Api\V1\OrderController::class, 'show']);

        // Payment
        Route::post('/payments/midtrans/token', [\App\Http\Controllers\Api\V1\PaymentController::class, 'getToken']);

        // Wishlist
        Route::get('/wishlist', [\App\Http\Controllers\Api\V1\WishlistController::class, 'index']);
        Route::post('/wishlist/toggle', [\App\Http\Controllers\Api\V1\WishlistController::class, 'toggle']);
        Route::post('/wishlist/check', [\App\Http\Controllers\Api\V1\WishlistController::class, 'check']);
        Route::delete('/wishlist/{id}', [\App\Http\Controllers\Api\V1\WishlistController::class, 'destroy']);
        Route::delete('/wishlist/clear', [\App\Http\Controllers\Api\V1\WishlistController::class, 'clear']);

        // Admin Settings
        Route::get('/admin/settings', [\App\Http\Controllers\Api\V1\SettingController::class, 'index']);
        Route::put('/admin/settings', [\App\Http\Controllers\Api\V1\SettingController::class, 'update']);
    });

    // Public Payment Callback
    Route::post('/payments/midtrans/callback', [\App\Http\Controllers\Api\V1\PaymentController::class, 'callback']);
});