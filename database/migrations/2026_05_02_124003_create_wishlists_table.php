<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (!Schema::hasTable('wishlists')) {
            Schema::create('wishlists', function (Blueprint $table) {
                $table->id();
                $table->foreignId('user_id')->constrained()->onDelete('cascade');
                $table->foreignId('product_id')->constrained()->onDelete('cascade');
                $table->timestamps();

                $table->unique(['user_id', 'product_id']);
            });
        } else {
            Schema::table('wishlists', function (Blueprint $table) {
                if (!Schema::hasColumn('wishlists', 'user_id')) {
                    $table->foreignId('user_id')->nullable()->constrained()->onDelete('cascade');
                }
                if (!Schema::hasColumn('wishlists', 'product_id')) {
                    $table->foreignId('product_id')->nullable()->constrained()->onDelete('cascade');
                }
                if (!Schema::hasColumn('wishlists', 'created_at')) {
                    $table->timestamps();
                }
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('wishlists');
    }
};
