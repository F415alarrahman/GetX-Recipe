import 'package:get/get.dart';
import 'package:recipe/app/data/services/auth_service.dart';
import 'package:recipe/app/data/services/recipe_service.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<RecipeService>(
      () => RecipeService(),
    );
    Get.lazyPut<AuthService>(
      () => AuthService(),
    );
  }
}
