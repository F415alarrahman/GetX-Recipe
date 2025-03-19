import 'package:get/get.dart';
import 'package:recipe/app/data/services/recipe_service.dart';

class RecipeController extends GetxController {
  var recipeDetail = {}.obs;
  var isLoading = false.obs;
  final RecipeService _recipeServices = RecipeService();

  void fetchRecipeById(int id) async {
    isLoading.value = true;
    var data = await _recipeServices.getRecipeById(id);
    if (data != null) {
      recipeDetail.value = data;
    } else {
      Get.snackbar("Error", "Failed to load recipe details.");
    }
    isLoading.value = false;
  }
}
