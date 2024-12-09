import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventoryFormController extends GetxController {
  // Form Key
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final itemCodeController = TextEditingController();
  final companyNameController = TextEditingController();
  final brandController = TextEditingController();
  final modelNumberController = TextEditingController();
  final configurationController = TextEditingController();
  final serialNumberController = TextEditingController();
  final statusController = TextEditingController();
  final purchaseDateController = TextEditingController();
  final amountController = TextEditingController();
  final sellerNameController = TextEditingController();
  final sellerPhoneNumberController = TextEditingController();
  final sellerAddressController = TextEditingController();
  final sellDateController = TextEditingController();
  final sellAmountController = TextEditingController();
  final buyerNameController = TextEditingController();
  final buyerPhoneNumberController = TextEditingController();
  final buyerAddressController = TextEditingController();

  // Dropdown state
  RxString selectedDropdownItem = ''.obs;
  RxString selectedBuyer = ''.obs;
  RxString selectedSeller = ''.obs;

  // Dropdown options
  final items = ['Sell', 'Stock'];
  final buyer = ['tata', 'bata'];
  final seller = ['ambani', 'adani'];
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
