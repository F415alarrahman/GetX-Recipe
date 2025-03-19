import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe/app/data/services/auth_service.dart';
import 'package:recipe/app/data/services/recipe_service.dart';

class HomeController extends GetxController {
  var recipes = [].obs;
  var isLoading = false.obs;
  final RecipeService _recipeServices = RecipeService();
  final AuthService authService = AuthService(); // ✅ AuthService untuk logout

  @override
  void onInit() {
    super.onInit();
    fetchRecipes();
  }

  void fetchRecipes() async {
    isLoading.value = true;
    var data = await _recipeServices.getAllRecipe();
    recipes.value = data;
    isLoading.value = false;
  }

  void confirmLogout() {
    // 🔥 Fungsi untuk konfirmasi logout
    Get.defaultDialog(
      title: "Konfirmasi Logout",
      middleText: "Apakah Anda yakin ingin keluar?",
      textCancel: "Batal",
      textConfirm: "Logout",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        await authService.logout(); // ✅ Panggil logout
        Get.offAllNamed(
            '/login'); // 🔥 Redirect ke halaman login setelah logout
      },
    );
  }
}
