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
        Schema::create('refunds', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->foreignUuid('order_id')->constrained()->cascadeOnDelete();
            $table->foreignUuid('payment_id')->constrained()->cascadeOnDelete();
            $table->foreignUuid('requested_by')->constrained('users')->restrictOnDelete();
            $table->bigInteger('amount');
            $table->enum('status', ['pending', 'approved', 'processing', 'completed', 'rejected'])
                ->default('pending');
            $table->string('reason', 255);
            $table->text('description')->nullable();
            $table->json('evidence_urls')->nullable();
            $table->text('admin_notes')->nullable();
            $table->string('gateway_refund_id', 100)->nullable();
            $table->timestamp('processed_at')->nullable();
            $table->timestamps();

            $table->index('order_id');
            $table->index('status');
        });

        Schema::create('shipments', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->foreignUuid('order_id')->constrained()->cascadeOnDelete();
            $table->string('courier_code', 20);
            $table->string('courier_service', 30);
            $table->string('tracking_number', 50);
            $table->enum('status', [
                'pending',
                'picked_up',
                'in_transit',
                'out_for_delivery',
                'delivered',
                'failed'
            ])->default('pending');
            $table->json('tracking_history')->nullable();
            $table->string('shipper_name', 100);
            $table->text('shipper_address');
            $table->timestamp('picked_up_at')->nullable();
            $table->timestamp('delivered_at')->nullable();
            $table->timestamps();

            $table->index('order_id');
            $table->index('tracking_number');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('shipments');
        Schema::dropIfExists('refunds');
    }

    /**
     * Reverse the migrations.
     */

};
