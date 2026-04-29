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
        Schema::table('users', function (Blueprint $table) {
            $table->string('phone', 20)->nullable()->unique()->after('email');
            $table->string('avatar_url', 500)->nullable()->after('phone');
            $table->enum('role', ['customer', 'admin', 'super_admin'])
                ->default('customer')->after('avatar_url');
            $table->enum('status', ['active', 'suspended', 'deleted'])
                ->default('active')->after('role');
            $table->timestamp('last_login_at')->nullable()->after('remember_token');
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn(['phone', 'avatar_url', 'role', 'status', 'last_login_at']);
        });
    }
};
