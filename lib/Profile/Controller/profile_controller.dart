import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Model/profile_model.dart';

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
  @override
void onClose() {
  nameController.dispose();
  phoneNumberController.dispose();
  cityController.dispose();
  roleName.dispose();
  pincodeController.dispose();
  gstNumberController.dispose();
  addressController.dispose();
  super.onClose();
}
var isLoading = false.obs;

  Future<void> saveProfileData() async {
   String generateUniqueNumber([DateTime? date]) {
        date ??= DateTime.now(); // Use current date-time if not provided
        return date.millisecondsSinceEpoch.toRadixString(36);
      }
    try {
      if (formKey.currentState!.validate()) {
        ProfileModel customer = ProfileModel(
          phone: phoneNumberController.text,
          name: nameController.text,
          city: cityController.text,
          pincode: pincodeController.text,
          gstNumber: gstNumberController.text,
          role: roleName.text,
          updatedAt: DateTime.now().millisecondsSinceEpoch,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          uid: generateUniqueNumber()
        );

        Map<String, dynamic> customerData = customer.toJson();
        await FirebaseFirestore.instance
            .collection('myprofile')
            .add(customerData);
        print("myprofile data saved successfully.");
        Get.back(result: true); // Go back to the previous screen
      } 
    } catch (e) {
      print("Error saving myprofile data: $e");
    } finally {isLoading.value = false;}
  }

  void cancelsaving() {
    Get.back();
  }
}
