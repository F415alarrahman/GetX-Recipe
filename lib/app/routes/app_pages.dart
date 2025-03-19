import 'package:get/get.dart';
import 'package:recipe/app/modules/recipe/bindings/recipe_binding.dart';
import 'package:recipe/app/modules/recipe/views/recipe_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '${_Paths.RECIPE}/:id', // 🔥 Tambahkan `/:id` untuk menangkap ID
      page: () =>
          RecipeView(recipeId: int.tryParse(Get.parameters['id'] ?? '0') ?? 0),
      binding: RecipeBinding(),
    ),
  ];
}
