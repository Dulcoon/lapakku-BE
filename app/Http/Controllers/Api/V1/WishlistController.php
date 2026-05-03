<?php

namespace App\Http\Controllers\Api\V1;

use App\Models\Wishlist;
use App\Http\Resources\ProductResource;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class WishlistController extends Controller
{
    public function index(Request $request)
    {
        $wishlistItems = Wishlist::with([
            'product.images',
            'product.variants.attributeValues.attribute',
            'product.variants.images',
            'product.category',
        ])
            ->where('user_id', $request->user()->id)
            ->latest()
            ->get();

        return response()->json($wishlistItems->map(function ($item) {
            return [
                'id' => $item->id,
                'user_id' => $item->user_id,
                'product_id' => $item->product_id,
                'created_at' => $item->created_at,
                'updated_at' => $item->updated_at,
                'product' => (new ProductResource($item->product))->resolve(),
            ];
        }));
    }

    public function toggle(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
        ]);

        $userId = $request->user()->id;
        $productId = $request->product_id;

        $wishlist = Wishlist::where('user_id', $userId)
            ->where('product_id', $productId)
            ->first();

        if ($wishlist) {
            $wishlist->delete();
            return response()->json([
                'message' => 'Removed from wishlist',
                'in_wishlist' => false,
            ]);
        }

        Wishlist::create([
            'user_id' => $userId,
            'product_id' => $productId,
        ]);

        return response()->json([
            'message' => 'Added to wishlist',
            'in_wishlist' => true,
        ]);
    }

    public function check(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
        ]);

        $exists = Wishlist::where('user_id', $request->user()->id)
            ->where('product_id', $request->product_id)
            ->exists();

        return response()->json(['in_wishlist' => $exists]);
    }

    public function destroy($id, Request $request)
    {
        $wishlist = Wishlist::where('user_id', $request->user()->id)
            ->where('id', $id)
            ->firstOrFail();

        $wishlist->delete();

        return response()->json(['message' => 'Removed from wishlist']);
    }

    public function clear(Request $request)
    {
        Wishlist::where('user_id', $request->user()->id)->delete();

        return response()->json(['message' => 'Wishlist cleared']);
    }
}
