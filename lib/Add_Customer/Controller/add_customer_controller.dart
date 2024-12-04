import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Model/customer_model.dart';

class AddCustomerController extends GetxController {
  // Form Key
  final formKey = GlobalKey<FormState>();
  var isLoader = false.obs;

  // Text Controllers
  final customerName = TextEditingController();
  final phoneNumberController = TextEditingController();
  final customerAddressController = TextEditingController();

  // Clear input fields
  void refresh() {
    customerName.clear();
    phoneNumberController.clear();
    customerAddressController.clear();
    formKey.currentState?.reset();
  }

  // Save Data Method
  Future<void> saveData(String buttonType) async {
    // Start loader
    isLoader.value = true;

    // Check the button type and validate accordingly
    if (buttonType.toLowerCase() == 'save') {
      // Validate the form for 'Save'
      if (formKey.currentState!.validate()) {
        await _saveCustomer(); // Call to save the customer
        Get.back(result: true); // Go back to the previous screen
      } else {
        isLoader.value = false; // Reset loader if validation fails
      }
    } else if (buttonType.toLowerCase() == 'save+next') {
      // Validate but do not reset fields if they fail
      if (formKey.currentState!.validate()) {
        await _saveCustomer(); // Call to save the customer
        refresh(); // Clear fields for new entry
      } else {
        isLoader.value = false; // Reset loader if validation fails
      }
    }
  }

  Future<void> _saveCustomer() async {
    try {
      // Get current timestamp for createdAt
      DateTime now = DateTime.now();
      DateTime createdAt = DateTime(now.year, now.month - 1, now.day); // Previous month

      // Create a new customer model with form data
      CustomerModel customer = CustomerModel(
        phone: phoneNumberController.text,
        name: customerName.text,
        createdAt: createdAt, // Store as timestamp
        billingAddress: customerAddressController.text,
        updatedAt: null, // Or set it to current timestamp if needed
      );

      // Convert the model to a JSON map
      Map<String, dynamic> customerData = customer.toJson();

      // Save to Firestore
      await FirebaseFirestore.instance.collection('customers').add(customerData);
      print("Customer data saved successfully.");
    } catch (e) {
      print("Error saving customer data: $e");
    } finally {
      isLoader.value = false; // Reset loader state
    }
  }

  // Cancel saving operation
  void cancelSaving() {
    Get.back(result: true);
  }
}
