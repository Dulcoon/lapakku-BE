<?php

namespace App\Http\Controllers\Api\V1;

use App\Models\Product;
use App\Models\Category;
use App\Models\ProductImage;
use App\Models\ProductVariant;
use App\Models\ProductAttribute;
use App\Http\Controllers\Controller;
use App\Http\Resources\ProductResource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class ProductController extends Controller
{
    const MAX_GALLERY_IMAGES = 5;
    const MAX_VARIANT_IMAGES = 2;

    public function index(Request $request)
    {
        $query = Product::query()
            ->with([
                'variants.attributeValues.attribute',
                'variants.images',
                'images',
                'category'
            ])
            ->where('status', 'active');

        if ($request->filled('search')) {
            $search = $request->string('search')->toString();
            $query->where(function ($q) use ($search) {
                $q->where('name', 'ilike', "%{$search}%")
                  ->orWhere('description', 'ilike', "%{$search}%");
            });
        }

        if ($request->filled('category_id')) {
            $query->where('category_id', $request->string('category_id'));
        }

        if ($request->filled('min_price')) {
            $minPrice = $request->integer('min_price');
            $query->whereHas('variants', function ($q) use ($minPrice) {
                $q->where('price', '>=', $minPrice);
            });
        }

        if ($request->filled('max_price')) {
            $maxPrice = $request->integer('max_price');
            $query->whereHas('variants', function ($q) use ($maxPrice) {
                $q->where('price', '<=', $maxPrice);
            });
        }

        if ($request->filled('min_rating')) {
            $minRating = $request->float('min_rating');
            $query->where('average_rating', '>=', $minRating);
        }

        $sort = $request->string('sort')->toString();
        match ($sort) {
            'price_asc' => $query->orderBy('price'),
            'price_desc' => $query->orderByDesc('price'),
            'newest' => $query->latest(),
            'name_asc' => $query->orderBy('name'),
            default => $query->latest(),
        };

        $products = $query->paginate($request->integer('per_page', 12));

        return ProductResource::collection($products);
    }

    public function show($slug)
    {
        $product = Product::query()
            ->with([
                'variants.attributeValues.attribute',
                'variants.images',
                'images',
                'category'
            ])
            ->where('slug', $slug)
            ->firstOrFail();

        return new ProductResource($product);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'category_id' => 'required|exists:categories,id',
            'price' => 'required|numeric|min:0',
            'stock' => 'required|integer|min:0',
            'description' => 'nullable|string',
            'images.*' => 'nullable|image|mimes:jpeg,png,jpg,webp|max:2048',
            'variant_images.*' => 'nullable|array',
            'variant_images.*.*' => 'image|mimes:jpeg,png,jpg,webp|max:2048',
            'has_variants' => 'nullable',
            'options' => 'nullable|string',
            'variants' => 'nullable|string',
        ]);

        return DB::transaction(function () use ($validated, $request) {
            $product = Product::create([
                'name' => $validated['name'],
                'slug' => Str::slug($validated['name']) . '-' . uniqid(),
                'category_id' => $validated['category_id'],
                'description' => $validated['description'],
                'status' => 'active',
            ]);

            $this->handleGalleryUploads($product, $request, true);

            if ($request->has_variants == "1" && $request->options && $request->variants) {
                $this->handleVariants($product, $request->options, $request->variants, $validated);
                $this->handleVariantImageUploads($product, $request);
            } else {
                $variant = $product->variants()->create([
                    'sku' => $this->generateSku($product),
                    'price' => $validated['price'],
                    'stock' => $validated['stock'],
                    'weight_gram' => 0,
                ]);
                $this->handleVariantImageUploadsForNewVariant($product, $variant, $request);
            }

            return new ProductResource($product->load(['category', 'variants.attributeValues.attribute', 'variants.images', 'images']));
        });
    }

    public function update(Request $request, $id)
    {
        $product = Product::findOrFail($id);

        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'category_id' => 'required|exists:categories,id',
            'price' => 'required|numeric|min:0',
            'stock' => 'required|integer|min:0',
            'description' => 'nullable|string',
            'images.*' => 'nullable|image|mimes:jpeg,png,jpg,webp|max:2048',
            'variant_images.*' => 'nullable|array',
            'variant_images.*.*' => 'image|mimes:jpeg,png,jpg,webp|max:2048',
            'has_variants' => 'nullable',
            'options' => 'nullable|string',
            'variants' => 'nullable|string',
            'primary_image_id' => 'nullable|uuid|exists:product_images,id',
        ]);

        return DB::transaction(function () use ($validated, $request, $product) {
            $product->update([
                'name' => $validated['name'],
                'category_id' => $validated['category_id'],
                'description' => $validated['description'],
            ]);

            $this->updateGallery($product, $request, $validated['primary_image_id'] ?? null);
            $this->handleGalleryUploads($product, $request, false);

            if ($request->has_variants == "1" && $request->options && $request->variants) {
                $this->handleVariants($product, $request->options, $request->variants, $validated);
                $this->handleVariantImageUploads($product, $request);
            } else {
                $product->variants()->delete();

                $variant = $product->variants()->create([
                    'sku' => $this->generateSku($product),
                    'price' => $validated['price'],
                    'stock' => $validated['stock'],
                    'weight_gram' => 0,
                ]);
                $this->handleVariantImageUploadsForNewVariant($product, $variant, $request);
            }

            return new ProductResource($product->load(['category', 'variants.attributeValues.attribute', 'variants.images', 'images']));
        });
    }

    public function destroy($id)
    {
        $product = Product::findOrFail($id);

        return DB::transaction(function () use ($product) {
            foreach ($product->images as $image) {
                Storage::disk('public')->delete($image->url);
            }

            foreach ($product->variants as $variant) {
                foreach ($variant->images as $image) {
                    Storage::disk('public')->delete($image->url);
                }
                $variant->images()->delete();
            }

            $product->images()->delete();
            $product->variants()->delete();
            $product->delete();

            return response()->json(['message' => 'Product deleted successfully']);
        });
    }

    private function handleGalleryUploads($product, $request, bool $isNew): void
    {
        if (!$request->hasFile('images')) {
            return;
        }

        $files = $request->file('images');
        if (!is_array($files)) {
            $files = [$files];
        }

        $existingGalleryCount = $product->images()->whereNull('variant_id')->count();

        if (!$isNew && ($existingGalleryCount + count($files)) > self::MAX_GALLERY_IMAGES) {
            return;
        }

        if ($isNew && count($files) > self::MAX_GALLERY_IMAGES) {
            $files = array_slice($files, 0, self::MAX_GALLERY_IMAGES);
        }

        foreach ($files as $index => $file) {
            $path = $file->store('products/gallery', 'public');
            $sortOrder = $isNew ? $index : $existingGalleryCount + $index;
            $isPrimary = ($sortOrder === 0) && $existingGalleryCount === 0;

            $product->images()->create([
                'url' => $path,
                'is_primary' => $isPrimary,
                'sort_order' => $sortOrder,
            ]);
        }
    }

    private function updateGallery($product, $request, ?string $primaryImageId): void
    {
        $existingIds = $request->input('existing_gallery_image_ids', []);
        if (!is_array($existingIds)) {
            $existingIds = [];
        }

        $existingGalleryImages = $product->images()->whereNull('variant_id')->get();

        foreach ($existingGalleryImages as $image) {
            if (!in_array($image->id, $existingIds)) {
                Storage::disk('public')->delete($image->url);
                $image->delete();
            }
        }

        if ($primaryImageId) {
            $product->images()->whereNull('variant_id')->update(['is_primary' => false]);
            $product->images()->where('id', $primaryImageId)->update(['is_primary' => true]);
        }

        $remainingImages = $product->images()->whereNull('variant_id')->orderBy('sort_order')->get();
        foreach ($remainingImages as $index => $image) {
            $image->update(['sort_order' => $index]);
        }
    }

    private function handleVariantImageUploads($product, $request): void
    {
        $variantImagesData = $request->input('variant_images', []);
        if (!is_array($variantImagesData)) {
            return;
        }

        foreach ($product->variants as $variant) {
            $variantIdStr = (string) $variant->id;
            $variantImageFiles = $request->file("variant_images.{$variantIdStr}");

            if ($variantImageFiles) {
                $this->uploadVariantImages($variant, $variantImageFiles);
            }
        }

        $existingVariantImageIdsData = $request->input('variant_existing_image_ids', []);
        if (is_array($existingVariantImageIdsData)) {
            foreach ($existingVariantImageIdsData as $variantId => $imageIds) {
                $variant = $product->variants()->find($variantId);
                if (!$variant) continue;

                if (!is_array($imageIds)) {
                    $imageIds = [];
                }

                $existingImages = $variant->images()->get();
                foreach ($existingImages as $image) {
                    if (!in_array($image->id, $imageIds)) {
                        Storage::disk('public')->delete($image->url);
                        $image->delete();
                    }
                }
            }
        }
    }

    private function handleVariantImageUploadsForNewVariant($product, $variant, $request): void
    {
        $variantIdStr = (string) $variant->id;
        $variantImageFiles = $request->file("variant_images.{$variantIdStr}");

        if ($variantImageFiles) {
            $this->uploadVariantImages($variant, $variantImageFiles);
        }
    }

    private function uploadVariantImages($variant, $files): void
    {
        if (!is_array($files)) {
            $files = [$files];
        }

        $existingCount = $variant->images()->count();
        $allowedSlots = max(0, self::MAX_VARIANT_IMAGES - $existingCount);
        $files = array_slice($files, 0, $allowedSlots);

        foreach ($files as $index => $file) {
            $path = $file->store('products/variants', 'public');
            $variant->images()->create([
                'product_id' => $variant->product_id,
                'url' => $path,
                'is_primary' => ($existingCount + $index) === 0,
                'sort_order' => $existingCount + $index,
            ]);
        }
    }

    private function handleVariants($product, $optionsJson, $variantsJson, $validated)
    {
        $options = json_decode($optionsJson, true);
        $variantsData = json_decode($variantsJson, true);

        if (!$options || !$variantsData) {
            return;
        }

        $existingVariants = $product->variants()->get();
        $baseVariant = $product->variants()
            ->withCount('attributeValues')
            ->orderBy('created_at')
            ->first();

        $defaultPrice = $validated['price'] ?? $baseVariant?->price ?? 0;

        $carrySingleVariantStock = $existingVariants->count() === 1
            && $baseVariant
            && (int) $baseVariant->attribute_values_count === 0
            ? $baseVariant->stock
            : null;

        $didCarrySingleVariantStock = false;

        $valueMap = [];
        foreach ($options as $opt) {
            $attribute = ProductAttribute::firstOrCreate(['name' => $opt['name']]);
            foreach ($opt['values'] as $val) {
                $attrValue = $attribute->values()->firstOrCreate(['value' => $val]);
                $valueMap[$opt['name']][$val] = $attrValue->id;
            }
        }

        $newVariantIds = [];
        foreach ($variantsData as $v) {
            $existingVariant = null;
            if (!empty($v['id'])) {
                $existingVariant = $existingVariants->firstWhere('id', $v['id']);
            }
            if (!$existingVariant && !empty($v['sku'])) {
                $existingVariant = $existingVariants->firstWhere('sku', $v['sku']);
            }

            $sku = !empty($v['sku'])
                ? $v['sku']
                : ($existingVariant?->sku ?? $this->generateSku($product, $v['name'] ?? null));

            $price = array_key_exists('price', $v) && $v['price'] !== '' && $v['price'] !== null
                ? $v['price']
                : ($existingVariant?->price ?? $defaultPrice);

            $stockProvided = array_key_exists('stock', $v) && $v['stock'] !== '' && $v['stock'] !== null;
            if ($stockProvided) {
                $stock = $v['stock'];
            } elseif ($existingVariant) {
                $stock = $existingVariant->stock;
            } elseif ($carrySingleVariantStock !== null && !$didCarrySingleVariantStock) {
                $stock = $carrySingleVariantStock;
                $didCarrySingleVariantStock = true;
            } else {
                $stock = 0;
            }

            $variant = $product->variants()->updateOrCreate(
                ['sku' => $sku],
                [
                    'price' => $price,
                    'stock' => $stock,
                    'weight_gram' => 0,
                ]
            );
            $newVariantIds[] = $variant->id;

            $attrValueIds = [];
            foreach (($v['option_values'] ?? []) as $optName => $valName) {
                if (isset($valueMap[$optName][$valName])) {
                    $attrValueIds[] = $valueMap[$optName][$valName];
                }
            }
            $variant->attributeValues()->sync($attrValueIds);
        }

        $product->variants()->whereNotIn('id', $newVariantIds)->each(function ($v) {
            foreach ($v->images as $img) {
                Storage::disk('public')->delete($img->url);
            }
            $v->images()->delete();
            $v->delete();
        });
    }

    private function generateSku($product, $variantName = null)
    {
        $category = Category::find($product->category_id);
        $catPrefix = strtoupper(substr($category->name ?? 'PRD', 0, 3));
        $randomPart = strtoupper(Str::random(4));
        $sequence = str_pad(Product::count() + 1, 3, '0', STR_PAD_LEFT);

        $sku = "{$catPrefix}-{$randomPart}-{$sequence}";
        if ($variantName) {
            $variantSuffix = strtoupper(substr(preg_replace('/[^A-Za-z0-9]/', '', $variantName), 0, 3));
            $sku .= "-{$variantSuffix}";
        }

        return $sku;
    }
}
