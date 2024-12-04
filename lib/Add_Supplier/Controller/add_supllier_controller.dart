import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Model/supplier_model.dart';

class SupplierFormController extends GetxController {
  // Form Key for validating the form
  final formKey = GlobalKey<FormState>();

  // Observable for loader
  var isLoader = false.obs;

  // Text Controllers for form fields
  final supplierName = TextEditingController();
  final phoneNumberController = TextEditingController();
  final supplierAddressController = TextEditingController();


  void refresh() {
    supplierName.clear();
    phoneNumberController.clear();
    supplierAddressController.clear();
    formKey.currentState?.reset();
  }

  // Save Supplier Data based on button type
  Future<void> saveData(String buttonType) async {
    isLoader.value = true; // Show loader

    if (buttonType.toLowerCase() == 'save') {
      // Save button: Validate and save, then go back
      if (formKey.currentState!.validate()) {
        await _saveSupplier(); // Save supplier data
        Get.back(result: true); // Close screen and pass success
      }
    } else if (buttonType.toLowerCase() == 'save+next') {
      // Save + Next button: Validate, save, and reset form
      if (formKey.currentState!.validate()) {
        await _saveSupplier(); // Save supplier data
        refresh(); // Reset form for new entry
      }
    }
    isLoader.value = false; // Hide loader
  }

  // Save supplier data to Firestore
  Future<void> _saveSupplier() async {
    try {
      // Get current date and adjust for previous month
      DateTime now = DateTime.now();
      DateTime createdAt = DateTime(now.year, now.month - 1, 1);

      // Create a SupplierModel object
      SupplierModel supplier = SupplierModel(
        name: supplierName.text,
        phone: phoneNumberController.text,
        supplierAddress: supplierAddressController.text,
        createdAt: createdAt,
        updatedAt: null,
      );

      // Convert the object to JSON
      Map<String, dynamic> supplierData = supplier.toJson();

      // Add the supplier data to Firestore
      await FirebaseFirestore.instance.collection('suppliers').add(supplierData);
      print("Supplier data saved successfully.");
    } catch (e) {
      print("Error saving supplier data: $e");
    }
  }

 

  void cancelsaving() {
    Get.back();
  }
}
