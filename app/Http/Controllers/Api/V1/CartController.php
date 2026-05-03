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
        $cart = Cart::with(['items.variant.product.images', 'items.variant.attributeValues.attribute'])
            ->where('user_id', $request->user()->id)
            ->first();

        if (!$cart) {
            return response()->json(null);
        }

        $formatImageUrl = function (?string $url): ?string {
            if (!$url) return null;
            if (str_starts_with($url, 'http')) return $url;
            return asset('storage/' . ltrim($url, '/'));
        };

        $cartItems = $cart->items->map(function ($item) use ($formatImageUrl) {
            $productImages = collect();
            if ($item->variant?->product?->images) {
                $productImages = $item->variant->product->images
                    ->whereNull('variant_id')
                    ->sortBy('sort_order')
                    ->map(fn($img) => [
                        'id' => $img->id,
                        'url' => $formatImageUrl($img->url),
                        'is_primary' => (bool) $img->is_primary,
                        'sort_order' => $img->sort_order ?? 0,
                    ])
                    ->values();
            }

            $attributeValues = collect();
            if ($item->variant) {
                $attributeValues = $item->variant->attributeValues->map(function ($av) {
                    return [
                        'id' => $av->id,
                        'value' => $av->value,
                        'attribute' => [
                            'id' => $av->attribute?->id,
                            'name' => $av->attribute?->name,
                        ]
                    ];
                });
            }

            return [
                'id' => $item->id,
                'variant_id' => $item->variant_id,
                'quantity' => $item->quantity,
                'price_snapshot' => $item->price_snapshot,
                'variant' => [
                    'id' => $item->variant?->id,
                    'sku' => $item->variant?->sku,
                    'price' => $item->variant?->price,
                    'stock' => $item->variant?->stock,
                    'product' => [
                        'id' => $item->variant?->product?->id,
                        'name' => $item->variant?->product?->name,
                        'slug' => $item->variant?->product?->slug,
                        'images' => $productImages,
                    ],
                    'attribute_values' => $attributeValues,
                ],
            ];
        });

        return response()->json([
            'id' => $cart->id,
            'user_id' => $cart->user_id,
            'items' => $cartItems,
        ]);
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

    // UPDATE CART ITEM QTY
    public function update(Request $request, $id)
    {
        $request->validate([
            'quantity' => 'required|integer|min:1',
        ]);

        $item = CartItem::findOrFail($id);

        if ($item->cart->user_id !== $request->user()->id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $item->update(['quantity' => $request->quantity]);

        return response()->json(['message' => 'Quantity updated']);
    }

    // REMOVE ITEM
    public function remove($id)
    {
        CartItem::findOrFail($id)->delete();

        return response()->json(['message' => 'Item removed']);
    }
}
