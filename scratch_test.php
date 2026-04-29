<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\User;
use App\Models\Category;
use App\Models\Product;
use App\Models\ProductVariant;
use Illuminate\Support\Facades\Http;
use Illuminate\Http\Request;

// Find existing product variant
$variant = ProductVariant::first();
if (!$variant) die("No variants found\n");

echo "Testing flow with Variant: " . $variant->id . "\n";

// Emulate requests directly via test methods is hard outside of TestCase.
// Let's just use Laravel's test framework but WITHOUT RefreshDatabase.
