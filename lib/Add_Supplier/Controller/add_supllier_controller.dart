import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/firebase_collection.dart';
import 'package:inventoryappflutter/Model/supplier_model.dart';

class SupplierFormController extends GetxController {
  // Form Key for validating the form
  final formKey = GlobalKey<FormState>();

  // Observable for loader
  var isLoader = false.obs;
  SupplierModel? supplierToEdit;

  // Text Controllers for form fields
  final supplierName = TextEditingController();
  final phoneNumberController = TextEditingController();
  final supplierAddressController = TextEditingController();

  void setSupplierData(SupplierModel supplier) {
    supplierToEdit = supplier;
    supplierName.text = supplier.name!;
    phoneNumberController.text = supplier.phone!;
    supplierAddressController.text = supplier.supplierAddress!;
  }


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
         if (supplierToEdit != null)
         {
           await _updateSupplier(); // Call to update the existing customer
        } else {
           await _saveSupplier();
         }
        
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
     
      SupplierModel supplier = SupplierModel(
        name: supplierName.text,
        phone: phoneNumberController.text,
        supplierAddress: supplierAddressController.text,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        updatedAt: null,
      );

      // Convert the object to JSON
      Map<String, dynamic> supplierData = supplier.toJson();

      // Add the supplier data to Firestore
       await FirestoreCollections.suppliers.add(supplierData);
      print("Supplier data saved successfully.");
    } catch (e) {
      print("Error saving supplier data: $e");
    }
  }

   Future<void> _updateSupplier() async {
    try {
      if (supplierToEdit == null) return; 

      // Get the document reference using the customer's ID
    DocumentReference supplierRef =
          FirestoreCollections.suppliers.doc(supplierToEdit!.id); // Assuming your CustomerModel has an 'id' field

      Map<String, dynamic> updatedData = {
        'phone': phoneNumberController.text,
        'name': supplierName.text,
        'address': supplierAddressController.text,
        'updated_at': DateTime.now().millisecondsSinceEpoch, // Update timestamp
      };

      await supplierRef.update(updatedData);
      print("supplier data updated successfully.");
    } catch (e) {
      print("Error updating supplier data: $e");
    } finally {
      isLoader.value = false; // Reset loader state
    }
  }

 

  void cancelsaving() {
    Get.back();
  }
}
