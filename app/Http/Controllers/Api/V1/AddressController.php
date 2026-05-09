<?php
namespace App\Http\Controllers\Api\V1;

use App\Models\UserAddress;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class AddressController extends Controller
{
    public function index(Request $request)
    {
        $addresses = $request->user()
            ->addresses()
            ->orderByDesc('is_default')
            ->orderByDesc('created_at')
            ->get();

        return response()->json($addresses);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'label' => 'required|string|max:50',
            'recipient_name' => 'required|string|max:100',
            'phone' => 'required|string|max:20',
            'address_line' => 'required|string',
            'province' => 'required|string|max:80',
            'city' => 'required|string|max:80',
            'city_id' => 'nullable|string|max:20',
            'district' => 'required|string|max:80',
            'village' => 'nullable|string|max:80',
            'postal_code' => 'required|string|max:10',
            'latitude' => 'nullable|numeric',
            'longitude' => 'nullable|numeric',
            'is_default' => 'boolean',
        ]);

        $address = $request->user()->addresses()->create($validated);

        if ($address->is_default || !$request->user()->addresses()->where('is_default', true)->exists()) {
            $address->setAsDefault();
        }

        return response()->json([
            'message' => 'Alamat berhasil ditambahkan',
            'data' => $address,
        ]);
    }

    public function show(Request $request, $id)
    {
        $address = $request->user()->addresses()->findOrFail($id);

        return response()->json($address);
    }

    public function update(Request $request, $id)
    {
        $address = $request->user()->addresses()->findOrFail($id);

        $validated = $request->validate([
            'label' => 'sometimes|string|max:50',
            'recipient_name' => 'sometimes|string|max:100',
            'phone' => 'sometimes|string|max:20',
            'address_line' => 'sometimes|string',
            'province' => 'sometimes|string|max:80',
            'city' => 'sometimes|string|max:80',
            'city_id' => 'nullable|string|max:20',
            'district' => 'sometimes|string|max:80',
            'village' => 'nullable|string|max:80',
            'postal_code' => 'sometimes|string|max:10',
            'latitude' => 'nullable|numeric',
            'longitude' => 'nullable|numeric',
            'is_default' => 'boolean',
        ]);

        $address->update($validated);

        if ($request->is_default) {
            $address->setAsDefault();
        }

        return response()->json([
            'message' => 'Alamat berhasil diperbarui',
            'data' => $address->fresh(),
        ]);
    }

    public function destroy(Request $request, $id)
    {
        $address = $request->user()->addresses()->findOrFail($id);
        
        $wasDefault = $address->is_default;
        $address->delete();

        if ($wasDefault) {
            $firstAddress = $request->user()->addresses()->first();
            if ($firstAddress) {
                $firstAddress->update(['is_default' => true]);
            }
        }

        return response()->json(['message' => 'Alamat berhasil dihapus']);
    }

    public function setDefault(Request $request, $id)
    {
        $address = $request->user()->addresses()->findOrFail($id);
        $address->setAsDefault();

        return response()->json([
            'message' => 'Alamat utama berhasil diperbarui',
            'data' => $address->fresh(),
        ]);
    }
}