import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/homescreen.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>(); // Form key for validation
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var passwordVisible = false.obs; // Reactive variable for password visibility

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value; // Toggle visibility
  }

  void login() {
    if (formKey.currentState!.validate()) {
      // Navigate to Dashboard
      Get.to(() => HomePage());
    }
  }
}
