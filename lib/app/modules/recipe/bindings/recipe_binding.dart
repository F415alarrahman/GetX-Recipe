import 'package:get/get.dart';
import 'package:recipe/app/data/services/recipe_service.dart';

import '../controllers/recipe_controller.dart';

class RecipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeController>(
      () => RecipeController(),
    );

    Get.lazyPut<RecipeService>(
      () => RecipeService(),
    );
  }
}
