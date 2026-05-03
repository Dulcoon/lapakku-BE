<?php

namespace App\Http\Controllers\Api\V1;

use App\Models\Banner;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;

class BannerController extends Controller
{
    public function index()
    {
        return response()->json(
            Banner::orderBy('sort_order')->get()->map(function ($banner) {
                return [
                    'id' => $banner->id,
                    'image' => str_starts_with($banner->image, 'http') ? $banner->image : asset('storage/' . $banner->image),
                    'link_url' => $banner->link_url,
                    'sort_order' => $banner->sort_order,
                    'is_active' => (bool) $banner->is_active,
                ];
            })
        );
    }

    public function active()
    {
        return response()->json(
            Banner::where('is_active', true)
                ->orderBy('sort_order')
                ->get()
                ->map(function ($banner) {
                    return [
                        'id' => $banner->id,
                        'image' => str_starts_with($banner->image, 'http') ? $banner->image : asset('storage/' . $banner->image),
                        'link_url' => $banner->link_url,
                    ];
                })
        );
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'image' => 'required|image|mimes:jpeg,png,jpg,webp|max:5120',
            'link_url' => 'nullable|url',
        ]);

        $path = $request->file('image')->store('banners', 'public');

        $maxOrder = Banner::max('sort_order') ?? 0;

        $banner = Banner::create([
            'image' => $path,
            'link_url' => $validated['link_url'] ?? null,
            'sort_order' => $maxOrder + 1,
        ]);

        return response()->json([
            'id' => $banner->id,
            'image' => asset('storage/' . $banner->image),
            'link_url' => $banner->link_url,
            'sort_order' => $banner->sort_order,
            'is_active' => (bool) $banner->is_active,
        ]);
    }

    public function update(Request $request, $id)
    {
        $banner = Banner::findOrFail($id);

        $validated = $request->validate([
            'image' => 'nullable|image|mimes:jpeg,png,jpg,webp|max:5120',
            'link_url' => 'nullable|url',
            'sort_order' => 'nullable|integer|min:0',
            'is_active' => 'nullable|boolean',
        ]);

        if ($request->hasFile('image')) {
            Storage::disk('public')->delete($banner->image);
            $banner->image = $request->file('image')->store('banners', 'public');
        }

        $banner->update([
            'link_url' => $validated['link_url'] ?? $banner->link_url,
            'sort_order' => $validated['sort_order'] ?? $banner->sort_order,
            'is_active' => isset($validated['is_active']) ? (bool) $validated['is_active'] : $banner->is_active,
        ]);

        return response()->json([
            'id' => $banner->id,
            'image' => asset('storage/' . $banner->image),
            'link_url' => $banner->link_url,
            'sort_order' => $banner->sort_order,
            'is_active' => (bool) $banner->is_active,
        ]);
    }

    public function destroy($id)
    {
        $banner = Banner::findOrFail($id);
        Storage::disk('public')->delete($banner->image);
        $banner->delete();

        return response()->json(['message' => 'Banner deleted']);
    }

    public function reorder(Request $request)
    {
        $validated = $request->validate([
            'orders' => 'required|array',
            'orders.*.id' => 'required|exists:banners,id',
            'orders.*.sort_order' => 'required|integer|min:0',
        ]);

        foreach ($validated['orders'] as $order) {
            Banner::where('id', $order['id'])->update(['sort_order' => $order['sort_order']]);
        }

        return response()->json(['message' => 'Banners reordered']);
    }
}
