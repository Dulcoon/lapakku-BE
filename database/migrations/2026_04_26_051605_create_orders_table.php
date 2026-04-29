<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->foreignUuid('user_id')
                ->nullable()
                ->constrained()
                ->nullOnDelete();
            $table->string('order_number', 30)->unique();
            $table->enum('status', [
                'pending_payment',
                'paid',
                'processing',
                'shipped',
                'delivered',
                'completed',
                'cancelled',
                'refunded'
            ])->default('pending_payment');
            $table->bigInteger('subtotal');
            $table->bigInteger('shipping_cost')->default(0);
            $table->bigInteger('discount_amount')->default(0);
            $table->bigInteger('tax_amount')->default(0);
            $table->bigInteger('grand_total');

            // Snapshot alamat pengiriman
            $table->string('recipient_name', 100);
            $table->string('recipient_phone', 20);
            $table->text('shipping_address');
            $table->string('province', 80);
            $table->string('city', 80);
            $table->string('postal_code', 10);

            // Kurir
            $table->string('courier_code', 20);
            $table->string('courier_service', 30);
            $table->string('courier_etd', 30)->nullable();
            $table->string('tracking_number', 50)->nullable();

            $table->text('notes')->nullable();
            $table->foreignUuid('voucher_id')
                ->nullable()
                ->constrained('vouchers')
                ->nullOnDelete();

            // Timestamps status
            $table->timestamp('paid_at')->nullable();
            $table->timestamp('shipped_at')->nullable();
            $table->timestamp('delivered_at')->nullable();
            $table->timestamp('completed_at')->nullable();
            $table->timestamp('cancelled_at')->nullable();
            $table->timestamps();

            $table->index('user_id');
            $table->index('status');
            $table->index('order_number');
            $table->index('created_at');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};
