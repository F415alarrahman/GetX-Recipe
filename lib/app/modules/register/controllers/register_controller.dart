import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe/app/data/services/auth_service.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController
  var isLoading = false.obs;
  var isAuthenticated = false.obs;
  final authService = Get.find<AuthService>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> register(String name, String email, String password) async {
    isLoading.value = true;

    bool success =
        await authService.register(Get.context!, name, email, password);

    isLoading.value = false;

    if (success) {
      Get.snackbar("Success", "Registrasi berhasil! Silakan login.");
      Get.offAllNamed('/login');
    } else {
      Get.snackbar("Error", "Registrasi gagal, coba lagi nanti");
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
