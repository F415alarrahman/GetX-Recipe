import 'package:get/get.dart';
import 'package:recipe/app/data/services/auth_service.dart';

import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
    Get.lazyPut<AuthService>(
      () => AuthService(),
    );
  }
}
