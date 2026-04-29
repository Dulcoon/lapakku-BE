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
        Schema::create('payments', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->foreignUuid('order_id')
                ->constrained()
                ->cascadeOnDelete();
            $table->string('gateway', 30);
            $table->string('gateway_transaction_id', 100)->nullable()->unique();
            $table->string('payment_method', 50)->nullable();
            $table->enum('status', ['pending', 'paid', 'failed', 'expired', 'refunded'])
                ->default('pending');
            $table->bigInteger('amount');
            $table->json('gateway_response')->nullable();
            $table->string('payment_url', 500)->nullable();
            $table->timestamp('paid_at')->nullable();
            $table->timestamp('expired_at')->nullable();
            $table->timestamps();

            $table->index('order_id');
            $table->index('status');
            $table->index('gateway_transaction_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payments');
    }
};
