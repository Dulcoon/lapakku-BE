<?php
namespace App\Http\Controllers\Api\V1;

use App\Models\Cart;
use App\Models\CartItem;
use App\Models\ProductVariant;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class CartController extends Controller
{
    // GET CART
    public function index(Request $request)
    {
        $cart = Cart::with(['items.variant.product', 'items.variant.product.images'])
            ->where('user_id', $request->user()->id)
            ->first();

        return response()->json($cart);
    }

    // ADD TO CART
    public function add(Request $request)
    {
        $request->validate([
            'variant_id' => 'required|exists:product_variants,id',
            'quantity'   => 'required|integer|min:1',
        ]);

        $cart = Cart::firstOrCreate([
            'user_id' => $request->user()->id,
        ]);

        $item = CartItem::where('cart_id', $cart->id)
            ->where('variant_id', $request->variant_id)
            ->first();

        if ($item) {
            $item->increment('quantity', $request->quantity);
        } else {
            CartItem::create([
                'cart_id'        => $cart->id,
                'variant_id'     => $request->variant_id,
                'quantity'       => $request->quantity,
                'price_snapshot' => ProductVariant::find($request->variant_id)->price,
            ]);
        }

        return response()->json(['message' => 'Added to cart']);
    }

    // REMOVE ITEM
    public function remove($id)
    {
        CartItem::findOrFail($id)->delete();

        return response()->json(['message' => 'Item removed']);
    }
}
