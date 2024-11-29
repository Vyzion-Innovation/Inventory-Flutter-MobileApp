import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Form Key
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final cityController = TextEditingController();
   final roleName = TextEditingController();
  final pincodeController = TextEditingController();
  final gstNumberController = TextEditingController();
  final addressController = TextEditingController();

 

  // Save Data Method
   @override
  void onInit() {
    super.onInit();
    // Initialize the filtered list with all items
   roleName.text = 'Admin';
    
  }

  void saveData() {
    if (formKey.currentState!.validate()) {
      // Handle saving data logic
      print("Form Saved!");
    }
  }

  void cancelsaving() {
    Get.back();
  }
}
