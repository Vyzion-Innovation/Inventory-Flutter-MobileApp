import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:inventoryappflutter/BottomNavBar/View/navbar_screen.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/route_string_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>(); // Form key for validation
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var rememberMe = false.obs; 
  var passwordVisible = false.obs; 
   var isLoading = false.obs;

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value; // Toggle visibility
  }

  final FirebaseAuth auth = FirebaseAuth.instance; // Initialize Firebase Auth

  void toggleRememberMe(bool value) {
    rememberMe.value = value; // Update the value when checkbox is toggled
  }

    Future<void> login() async {
    isLoading.value = true; // Set loading state to true
    if (formKey.currentState!.validate()) {
      try {
        // Sign in with email and password
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // Check if login was successful
        if (userCredential.user != null) {
          // Save login state in shared preferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool(Strings.ifLogin, true);
          // Navigate to Dashboard
          Get.offAll(() => NavBarScreen());
        }
      } on FirebaseAuthException catch (e) {
        // Handle errors
        if (e.code == 'user-not-found') {
          Get.snackbar('Error', 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Get.snackbar('Error', 'Wrong password provided for that user.');
        } else {
          Get.snackbar('Error', 'An error occurred. Please try again.');
        }
      } finally {
        isLoading.value = false; // Set loading state to false
      }
    } else {
      isLoading.value = false; // Set loading state to false if form is invalid
    }
  }

  Future<void> logout() async {
    await auth.signOut(); // Sign out from Firebase
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Strings.ifLogin, false);
    // Navigate back to Login Screen
    Get.offAllNamed(RouteString.login);
  }
}
