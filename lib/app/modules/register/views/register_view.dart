import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe/app/modules/register/controllers/register_controller.dart';

class RegisterView extends StatelessWidget {
  final RegisterController registerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: registerController.nameController,
              decoration: InputDecoration(labelText: "Nama Lengkap"),
            ),
            TextField(
              controller: registerController.emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: registerController.passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            TextField(
              controller: registerController.confirmPasswordController,
              decoration: InputDecoration(labelText: "Konfirmasi Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Obx(() => registerController.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      if (registerController.passwordController.text ==
                          registerController.confirmPasswordController.text) {
                        registerController.register(
                          registerController.nameController.text,
                          registerController.emailController.text,
                          registerController.passwordController.text,
                        );
                      } else {
                        Get.snackbar("Error", "Password tidak cocok!");
                      }
                    },
                    child: Text("Daftar"),
                  )),
            TextButton(
              onPressed: () => Get.toNamed('/login'),
              child: Text("Sudah punya akun? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
