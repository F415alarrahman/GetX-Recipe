import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe/app/modules/login/controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Form(
          key: loginController.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                  controller: loginController.emailController,
                  decoration: InputDecoration(labelText: "Email")),
              TextField(
                  controller: loginController.passwordController,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true),
              SizedBox(height: 20),
              Obx(() => loginController.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () => loginController.login(
                          loginController.emailController.text,
                          loginController.passwordController.text),
                      child: Text("Login"),
                    )),
              TextButton(
                  onPressed: () => Get.toNamed('/register'),
                  child: Text("Belum punya akun? Daftar")),
            ],
          ),
        ),
      ),
    );
  }
}
