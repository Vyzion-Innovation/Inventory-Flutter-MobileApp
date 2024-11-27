import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/BottomNavBar/View/navbar_screen.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/route_string_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>(); // Form key for validation
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  var passwordVisible = false.obs; // Reactive variable for password visibility

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value; // Toggle visibility
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      // Save login state in shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(Strings.ifLogin, true);

      // Navigate to Dashboard
      Get.offAll(() => NavBarScreen());
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Strings.ifLogin, false);

    // Navigate back to Login Screen
    Get.offAllNamed(RouteString.login);
  }
}

