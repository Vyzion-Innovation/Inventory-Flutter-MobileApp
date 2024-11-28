import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepairFormController extends GetxController {
  // Form Key
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final customeNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final issueController = TextEditingController();
  final estimatedCostController = TextEditingController();
  final modelNumberController = TextEditingController();

  final statusController = TextEditingController();

  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  final finalCostController = TextEditingController();

  // Dropdown state
  RxString selectedDropdownItem = ''.obs;
  RxString selectedBuyer = ''.obs;
  RxString selectedSeller = ''.obs;

  // Dropdown options
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
