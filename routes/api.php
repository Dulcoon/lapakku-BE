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

    Route::middleware('auth:sanctum')->group(function () {
        // Categories Management (Admin)
        Route::post('/categories', [\App\Http\Controllers\Api\V1\CategoryController::class, 'store']);
        Route::put('/categories/{id}', [\App\Http\Controllers\Api\V1\CategoryController::class, 'update']);
        Route::delete('/categories/{id}', [\App\Http\Controllers\Api\V1\CategoryController::class, 'destroy']);

        // Cart API
        Route::get('/cart', [\App\Http\Controllers\Api\V1\CartController::class, 'index']);
        Route::post('/cart/add', [\App\Http\Controllers\Api\V1\CartController::class, 'add']);
        Route::delete('/cart/item/{id}', [\App\Http\Controllers\Api\V1\CartController::class, 'remove']);

        // Checkout & Orders
        Route::post('/checkout', [\App\Http\Controllers\Api\V1\OrderController::class, 'checkout']);
        Route::get('/orders', [\App\Http\Controllers\Api\V1\OrderController::class, 'orders']);
        Route::get('/orders/{id}', [\App\Http\Controllers\Api\V1\OrderController::class, 'show']);

        // Payment
        Route::post('/payments/midtrans/token', [\App\Http\Controllers\Api\V1\PaymentController::class, 'getToken']);
    });

    // Public Payment Callback
    Route::post('/payments/midtrans/callback', [\App\Http\Controllers\Api\V1\PaymentController::class, 'callback']);
});