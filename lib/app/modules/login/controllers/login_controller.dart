import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe/app/data/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var isAuthenticated = false.obs;
  AuthService authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus(); // Cek apakah user sudah login
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;

    try {
      print("[LOGIN CONTROLLER] Attempting login for: $email");

      bool success = await authService.login(Get.context!, email, password);

      isLoading.value = false;

      if (success) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('access_token');

        if (token != null) {
          print("[LOGIN CONTROLLER] Login successful, token saved: $token");
          isAuthenticated.value = true;
          Get.offAllNamed('/home'); // Navigasi ke Home setelah login
        } else {
          print("[LOGIN CONTROLLER] Login failed, token not found");
          Get.snackbar("Error", "Login gagal, token tidak ditemukan");
        }
      } else {
        print("[LOGIN CONTROLLER] Login failed, invalid credentials");
        Get.snackbar("Error", "Login gagal, periksa kembali email & password");
      }
    } catch (e) {
      print("[LOGIN CONTROLLER ERROR] ${e.toString()}");
      Get.snackbar("Error", "Terjadi kesalahan: ${e.toString()}");
    }
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token != null) {
      print("[LOGIN CONTROLLER] User is already authenticated");
      isAuthenticated.value = true;
      Get.offAllNamed('/home'); // Jika sudah login, langsung ke Home
    } else {
      print("[LOGIN CONTROLLER] No valid token found, redirecting to login");
      isAuthenticated.value = false;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    print("[LOGOUT] User logged out, token removed.");

    isAuthenticated.value = false;
    Get.offAllNamed('/login'); // Kembali ke halaman login setelah logout
  }
}
