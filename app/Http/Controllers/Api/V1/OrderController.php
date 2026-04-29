<?php
namespace App\Http\Controllers\Api\V1;

use App\Models\Cart;
use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class OrderController extends Controller
{
    public function checkout(Request $request)
    {
        $cart = Cart::with('items.variant.product.images')
            ->where('user_id', $request->user()->id)
            ->firstOrFail();

        if ($cart->items->isEmpty()) {
            return response()->json(['message' => 'Cart kosong'], 400);
        }

        $subtotal = 0;

        foreach ($cart->items as $item) {
            $subtotal += $item->variant->price * $item->quantity;
        }

        $shipping = 10000; // dummy dulu
        $total    = $subtotal + $shipping;

        $order = Order::create([
            'user_id'         => $request->user()->id,
            'order_number'    => 'ORD-' . now()->timestamp,
            'status'          => 'pending_payment',
            'subtotal'        => $subtotal,
            'shipping_cost'   => $shipping,
            'grand_total'     => $total,

            // dummy address dulu
            'recipient_name'  => 'Test User',
            'recipient_phone' => '08123456789',
            'shipping_address'=> 'Alamat dummy',
            'province'        => 'DIY',
            'city'            => 'Yogyakarta',
            'postal_code'     => '55123',

            'courier_code'    => 'jne',
            'courier_service' => 'REG',
        ]);

        // CREATE ORDER ITEMS
        foreach ($cart->items as $item) {
            OrderItem::create([
                'order_id'      => $order->id,
                'variant_id'    => $item->variant->id,
                'product_name'  => $item->variant->product->name,
                'sku'           => $item->variant->sku,
                'quantity'      => $item->quantity,
                'unit_price'    => $item->variant->price,
                'subtotal'      => $item->variant->price * $item->quantity,
                'product_image_url' => $item->variant->product->images->where('is_primary', true)->first()?->url,
            ]);
        }

        // CLEAR CART
        $cart->items()->delete();

        return response()->json([
            'message' => 'Checkout berhasil',
            'order_id' => $order->id
        ]);
    }

    public function orders(Request $request)
    {
        return Order::with('items')
            ->where('user_id', $request->user()->id)
            ->latest()
            ->get();
    }

    public function show($id, Request $request)
    {
        $order = Order::with('items')
            ->where('user_id', $request->user()->id)
            ->findOrFail($id);

        return response()->json($order);
    }
}
