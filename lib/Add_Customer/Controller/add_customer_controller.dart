import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:inventoryappflutter/Constant/firebase_collection.dart';
import 'package:inventoryappflutter/Model/customer_model.dart';

class AddCustomerController extends GetxController {
  // Form Key
  final formKey = GlobalKey<FormState>();
  var isLoader = false.obs;

  // Text Controllers
  final customerName = TextEditingController();
  final phoneNumberController = TextEditingController();
  final customerAddressController = TextEditingController();

  // For edit mode
  CustomerModel? customerToEdit;

  // Method to set customer data for editing
  void setCustomerData(CustomerModel customer) {
    customerToEdit = customer;
    customerName.text = customer.name!;
    phoneNumberController.text = customer.phone!;
    customerAddressController.text = customer.billingAddress!;
  }

  // Clear input fields
  @override
  void refresh() {
    customerName.clear();
    phoneNumberController.clear();
    customerAddressController.clear();
    formKey.currentState?.reset();
    customerToEdit = null; // Clear the edit data
  }

  // Save Data Method
  Future<void> saveData(String buttonType) async {
    isLoader.value = true;

    // Check the button type and validate accordingly
    if (buttonType.toLowerCase() == 'save') {
      // Validate the form for 'Save'
      if (formKey.currentState!.validate()) {
        if (customerToEdit != null) {
          await _updateCustomer(); // Call to update the existing customer
           await Get.defaultDialog(
          title: "Customer updated",
          content: const Text("Your data has been updated successfully."),
          confirm: ElevatedButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text("OK"),
          ),
        );
        } else {
          await _saveCustomer(); // Call to save the new customer
        }
        Get.back(result: true); // Go back to the previous screen
      } else {
        isLoader.value = false; // Reset loader if validation fails
      }
    } else if (buttonType.toLowerCase() == 'save+next') {
      // Validate but do not reset fields if they fail
      if (formKey.currentState!.validate()) {
        await _saveCustomer(); // Call to save the new customer
        Get.defaultDialog(
          title: "Data Saved",
          content: const Text("Your data has been saved successfully."),
          confirm: ElevatedButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text("OK"),
          ),
        );
        refresh(); // Clear fields for new entry
      } else {
        isLoader.value = false; // Reset loader if validation fails
      }
    }
  }

  // Save new customer
  Future<void> _saveCustomer() async {
    try {
      CustomerModel customer = CustomerModel(
        phone: phoneNumberController.text,
        name: customerName.text,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        billingAddress: customerAddressController.text,
        updatedAt: null,
      );

      Map<String, dynamic> customerData = customer.toJson();
      await FirestoreCollections.customers.add(customerData);
      print("Customer data saved successfully.");
    } catch (e) {
      print("Error saving customer data: $e");
    } finally {
      isLoader.value = false; // Reset loader state
    }
  }

  // Update existing customer
  Future<void> _updateCustomer() async {
    try {
      if (customerToEdit == null) return; // Ensure there's a customer to update

      // Get the document reference using the customer's ID
      DocumentReference supplierRef = FirestoreCollections.customers.doc(
          customerToEdit!.id); // Assuming your CustomerModel has an 'id' field

      Map<String, dynamic> updatedData = {
        'phone': phoneNumberController.text,
        'name': customerName.text,
        'billing_address': customerAddressController.text,
        'updated_at': DateTime.now().millisecondsSinceEpoch, // Update timestamp
      };

      await supplierRef.update(updatedData);
      print("Customer data updated successfully.");
    } catch (e) {
      print("Error updating customer data: $e");
    } finally {
      isLoader.value = false; // Reset loader state
    }
  }

  // Cancel saving operation
  void cancelSaving() {
    Get.back(result: true);
  }
}
