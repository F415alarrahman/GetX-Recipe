import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe/app/modules/recipe/controllers/recipe_controller.dart';

class RecipeView extends StatelessWidget {
  final int recipeId;

  RecipeView({required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final RecipeController detailController = Get.put(RecipeController());

    // 🔥 Panggil data berdasarkan ID dari URL
    detailController.fetchRecipeById(recipeId);

    return Scaffold(
      appBar: AppBar(title: const Text("Detail Resep")),
      body: Obx(() {
        if (detailController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        var recipe = detailController.recipeDetail;

        if (recipe.isEmpty) {
          return const Center(
            child: Text(
              "Data tidak ditemukan!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar Resep
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    recipe['photo_url'] ?? '',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 250,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image,
                          size: 50, color: Colors.grey),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Judul Resep
                Text(
                  recipe['title'] ?? 'No Title',
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                // Informasi Tambahan (Tanggal, Likes, Comments)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dibuat pada: ${recipe['created_at'] ?? 'No Date'}",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.thumb_up,
                            size: 16, color: Colors.blue),
                        const SizedBox(width: 4),
                        Text("${recipe['likes_count']?.toString() ?? '0'}"),
                        const SizedBox(width: 10),
                        const Icon(Icons.comment, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text("${recipe['comments_count']?.toString() ?? '0'}"),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                const Divider(), // 🔥 Pembatas antara bagian informasi

                // Deskripsi
                const SizedBox(height: 8),
                const Text(
                  "Deskripsi:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  recipe['description'] ?? 'No Description',
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 16),
                const Divider(), // 🔥 Pembatas antara bagian informasi

                // Cara Memasak
                const SizedBox(height: 8),
                const Text(
                  "Cara Memasak:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  recipe['cooking_method'] ?? 'No Cooking Method',
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 16),
                const Divider(), // 🔥 Pembatas antara bagian informasi

                // Bahan-bahan
                const SizedBox(height: 8),
                const Text(
                  "Bahan-bahan:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  recipe['ingredients'] ?? 'No Ingredients',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
