<?php

namespace App\Http\Controllers\Api\V1;

use App\Models\Order;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Services\SettingsService;
use Midtrans\Config;
use Midtrans\Snap;

class PaymentController extends Controller
{
    public function __construct()
    {
        Config::$serverKey = SettingsService::get('midtrans_server_key') ?? config('midtrans.server_key') ?? env('MIDTRANS_SERVER_KEY');
        Config::$isProduction = SettingsService::get('midtrans_is_production') ?: config('midtrans.is_production') ?? env('MIDTRANS_IS_PRODUCTION', false);
        Config::$isSanitized = true;
        Config::$is3ds = true;
    }

    public function getToken(Request $request)
    {
        $request->validate([
            'order_id' => 'required|string'
        ]);

        try {
            $order = Order::with(['items', 'user'])
                ->where('user_id', $request->user()->id)
                ->where('id', $request->order_id)
                ->firstOrFail();

            if ($order->status !== 'pending_payment') {
                return response()->json([
                    'message' => 'Order sudah dibayar atau tidak valid',
                    'status' => $order->status
                ], 400);
            }

            if ($order->items->isEmpty()) {
                return response()->json(['message' => 'Order tidak memiliki item'], 400);
            }

            if (!$order->user) {
                return response()->json(['message' => 'User tidak ditemukan'], 400);
            }

            $params = [
                'transaction_details' => [
                    'order_id' => $order->order_number,
                    'gross_amount' => (int) $order->grand_total,
                ],
                'customer_details' => [
                    'first_name' => $order->user->name,
                    'email' => $order->user->email,
                    'phone' => $order->recipient_phone ?? '',
                ],
                'item_details' => $order->items->map(function ($item) {
                    return [
                        'id' => $item->variant_id ?? 'item',
                        'price' => (int) $item->unit_price,
                        'quantity' => $item->quantity,
                        'name' => $item->product_name ?? 'Product',
                    ];
                })->toArray(),
            ];

            $snapToken = Snap::getSnapToken($params);
            
            return response()->json([
                'snap_token' => $snapToken
            ]);
        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error('Midtrans getToken Error: ' . $e->getMessage());
            return response()->json(['message' => 'Gagal membuat token pembayaran: ' . $e->getMessage()], 500);
        }
    }

    public function callback(Request $request)
    {
        \Illuminate\Support\Facades\Log::info('Midtrans Callback Received:', $request->all());

        // 1. Handle "Test notification URL" button from Midtrans
        if (str_contains($request->order_id, 'payment_notif_test')) {
            return response()->json(['message' => 'Test notification success'], 200);
        }

        $serverKey = SettingsService::get('midtrans_server_key') ?? config('midtrans.server_key') ?? env('MIDTRANS_SERVER_KEY');
        $hashed = hash("sha512", $request->order_id . $request->status_code . $request->gross_amount . $serverKey);

        if ($hashed !== $request->signature_key) {
            \Illuminate\Support\Facades\Log::warning('Midtrans Invalid Signature', [
                'expected' => $hashed,
                'received' => $request->signature_key
            ]);
            return response()->json(['message' => 'Invalid signature'], 403);
        }

        $order = Order::where('order_number', $request->order_id)->first();

        if (!$order) {
            \Illuminate\Support\Facades\Log::warning('Midtrans Order not found', ['order_id' => $request->order_id]);
            return response()->json(['message' => 'Order not found'], 404);
        }

        $transactionStatus = $request->transaction_status;
        $type = $request->payment_type;
        $fraud = $request->fraud_status;

        try {
            if ($transactionStatus == 'capture') {
                if ($type == 'credit_card') {
                    if ($fraud == 'challenge') {
                        $order->update(['status' => 'pending_payment']);
                    } else {
                        $order->update(['status' => 'paid']);
                    }
                }
            } else if ($transactionStatus == 'settlement') {
                $order->update(['status' => 'paid']);
            } else if ($transactionStatus == 'pending') {
                $order->update(['status' => 'pending_payment']);
            } else if ($transactionStatus == 'deny' || $transactionStatus == 'expire' || $transactionStatus == 'cancel') {
                $order->update(['status' => 'cancelled']);
            }

            return response()->json(['message' => 'Callback handled']);
        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error('Midtrans Callback Error: ' . $e->getMessage());
            return response()->json(['message' => 'Callback error: ' . $e->getMessage()], 500);
        }
    }
}
