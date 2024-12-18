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
final FirebaseAuth auth = FirebaseAuth.instance;

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value; // Toggle visibility
  }

   // Initialize Firebase Auth
   @override
  void onInit() {
    // TODO: implement onInit
    loadSavedCredentials();
    super.onInit();
  }

   void loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    rememberMe.value = prefs.getBool('rememberMe') ?? false;
    if (rememberMe.value) {
      emailController.text = prefs.getString('email') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
    }
  }

  void toggleRememberMe(bool value) async {
    rememberMe.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', value);
  }

  Future<void> login() async {
    isLoading.value = true;
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (userCredential.user != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool(Strings.ifLogin, true);
          if (rememberMe.value) {
            await prefs.setString('email', emailController.text);
            await prefs.setString('password', passwordController.text);
          }
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
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Strings.ifLogin, false);

    // Clear saved credentials if "Remember Me" is not selected
   

    Get.offAllNamed(RouteString.login);
  }
}