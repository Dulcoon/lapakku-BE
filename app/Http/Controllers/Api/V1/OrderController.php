<?php
namespace App\Http\Controllers\Api\V1;

use App\Models\Cart;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\UserAddress;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class OrderController extends Controller
{
    public function checkout(Request $request)
    {
        $request->validate([
            'address_id' => 'required|uuid|exists:user_addresses,id',
            'shipping_option' => 'required|array',
            'shipping_option.courier_code' => 'required|string',
            'shipping_option.service' => 'required|string',
            'shipping_option.cost' => 'required|integer',
            'shipping_option.etd' => 'nullable|string',
        ]);

        $address = UserAddress::where('user_id', $request->user()->id)
            ->findOrFail($request->address_id);

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

        $shipping = $request->shipping_option['cost'];
        $total = $subtotal + $shipping;

        $order = Order::create([
            'user_id' => $request->user()->id,
            'order_number' => 'ORD-' . now()->timestamp,
            'status' => 'pending_payment',
            'subtotal' => $subtotal,
            'shipping_cost' => $shipping,
            'grand_total' => $total,

            'recipient_name' => $address->recipient_name,
            'recipient_phone' => $address->phone,
            'shipping_address' => $address->address_line,
            'province' => $address->province,
            'city' => $address->city,
            'postal_code' => $address->postal_code,

            'courier_code' => $request->shipping_option['courier_code'],
            'courier_service' => $request->shipping_option['service'],
            'courier_etd' => $request->shipping_option['etd'] ?? null,
        ]);

        foreach ($cart->items as $item) {
            OrderItem::create([
                'order_id' => $order->id,
                'variant_id' => $item->variant->id,
                'product_name' => $item->variant->product->name,
                'sku' => $item->variant->sku,
                'quantity' => $item->quantity,
                'unit_price' => $item->variant->price,
                'subtotal' => $item->variant->price * $item->quantity,
                'product_image_url' => $item->variant->product->images->where('is_primary', true)->first()?->url,
            ]);
        }

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