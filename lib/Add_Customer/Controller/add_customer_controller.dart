import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCustomerController extends GetxController {
  // Form Key
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final supllierName = TextEditingController();
  final phoneNumberController = TextEditingController();
  final supplierAddressController = TextEditingController();

  

  // Save Data Method
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
