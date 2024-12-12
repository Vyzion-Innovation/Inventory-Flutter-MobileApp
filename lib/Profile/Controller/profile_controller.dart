import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/firebase_collection.dart';
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

  super.onClose();
}
ProfileModel? adminProfileData;
  // Set the inventory data when editing
 void setProfileData(ProfileModel profileData) {
    adminProfileData = profileData;
    cityController.text = profileData.city ?? '';
    nameController.text = profileData.name ?? '';
    pincodeController.text = profileData.pincode ?? '';
    gstNumberController.text = profileData.gstNumber ?? '';
    addressController.text = profileData.address ?? '';
    phoneNumberController.text = profileData.phone ?? ''; // Fix: Ensure you are setting the phone
    roleName.text = profileData.role ?? ''; // Fix: Ensure you are setting the role
}

var isLoading = false.obs;



  Future<void> saveData() async {
    isLoading.value = true;

    // Check the button type and validate accordingly
    
      // Validate the form for 'Save'
      if (formKey.currentState!.validate()) {
        if (adminProfileData != null) {
          await _updateProfile(); // Call to update the existing customer
        } else {
          await saveProfileData(); // Call to save the new customer
        }
        Get.back(result: true); // Go back to the previous screen
      } else {
        isLoading.value = false; // Reset loader if validation fails
      }
    
  }

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
          uid: generateUniqueNumber(),
          address: addressController.text,
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



  Future<void> _updateProfile() async {
  try {
    

    // Get the document reference using the profile's ID
    DocumentReference profileRef = FirestoreCollections.profile.doc(adminProfileData?.id);

    // Check if the document exists
   

    if (formKey.currentState!.validate()) {
      ProfileModel profiles = ProfileModel(
        phone: phoneNumberController.text,
        name: nameController.text,
        city: cityController.text,
        pincode: pincodeController.text,
        gstNumber: gstNumberController.text,
        role: roleName.text,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
        address: addressController.text,
        uid: adminProfileData?.uid,
        createdAt: adminProfileData?.createdAt,
      );

      Map<String, dynamic> updatedData = profiles.toJson();

      // Log the data being updated
      print("Updating profile with data: $updatedData");

      // Update the document
      await profileRef.update(updatedData);
      print("Profile data updated successfully.");
    } else {
      print("Form validation failed. Unable to update profile.");
    }
  } catch (e) {
    print("Error updating profile data: $e");
    Get.snackbar("Error", "Failed to update profile data: $e"); // Provide user feedback
  } finally {
    isLoading.value = false; // Reset loader state
  }
}



}
