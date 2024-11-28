import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Supplier/View/supllier_screen.dart';

class SupplierFormController extends GetxController {
  // Form Key
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final supllierName = TextEditingController();
  final phoneNumberController = TextEditingController();
  final supplierAddressController = TextEditingController();

  final items = ['Receive', 'Complete'];

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
