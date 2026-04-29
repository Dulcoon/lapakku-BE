<?php

namespace Database\Seeders;

use App\Models\Category;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Category::insert([
            [
                'id' => Str::uuid(),
                'name' => 'Elektronik',
                'slug' => 'elektronik',
            ],
            [
                'id' => Str::uuid(),
                'name' => 'Fashion',
                'slug' => 'fashion',
            ],
        ]);
    }
}
