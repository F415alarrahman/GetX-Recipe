import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe/app/modules/home/controllers/home_controller.dart';
import 'package:recipe/app/modules/recipe/views/recipe_view.dart';

class HomeView extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              homeController
                  .confirmLogout(); // 🔥 Tambahkan konfirmasi sebelum logout
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (homeController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (homeController.recipes.isEmpty) {
            return const Center(
              child: Text(
                "No recipes available.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            itemCount: homeController.recipes.length,
            itemBuilder: (context, index) {
              final recipe = homeController.recipes[index];

              return GestureDetector(
                onTap: () {
                  Get.to(() => RecipeView(
                      recipeId: recipe['id'])); // 🔥 Navigasi ke DetailPage
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3, // Menambah efek shadow
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gambar Resep
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.network(
                          recipe['photo_url'] ?? '',
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 180,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image,
                                size: 50, color: Colors.grey),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Judul Resep
                            Text(
                              recipe['title'] ?? 'No Title',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            // Deskripsi Resep
                            Text(
                              recipe['description'] ?? 'No Description',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),

                            const SizedBox(height: 8),

                            // Informasi Tambahan (Likes & Comments)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.thumb_up,
                                        size: 16, color: Colors.blue),
                                    const SizedBox(width: 4),
                                    Text("${recipe['likes_count'] ?? 0} Likes"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.comment,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                        "${recipe['comments_count'] ?? 0} Comments"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
