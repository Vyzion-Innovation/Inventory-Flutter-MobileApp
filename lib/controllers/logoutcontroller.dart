import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/homescreen.dart';
import 'package:inventoryappflutter/Login/View/login_screen.dart';

class LogoutController extends GetxController {
 

  void logout() {
    
      // Navigate to Dashboard
      Get.to(() => LoginScreenPage());
    
  }
}
