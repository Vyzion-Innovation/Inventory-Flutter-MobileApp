import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/firebase_collection.dart';
import 'package:inventoryappflutter/Model/customer_model.dart';
import 'package:inventoryappflutter/Model/inventory_model.dart';
import 'package:inventoryappflutter/Model/supplier_model.dart';

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
  final purchaseAmountController = TextEditingController();
  final sellDateController = TextEditingController();
  final sellAmountController = TextEditingController();
  final buyerNameController = TextEditingController();
  final buyerPhoneNumberController = TextEditingController();
  final buyerAddressController = TextEditingController();

  // Dropdown state

  var selectedBuyer = Rx<CustomerModel?>(null);
  var selectedSeller = Rx<SupplierModel?>(null);
  var selectedStatus = ''.obs;
  var selectedPaidBy = ''.obs;
  InventoryModel? inventoryToEdit;
  var items = ['Stock', 'Sell'];
  var paidBy = ['cash', 'card', 'online'];

  // List of buyers from the database
  List<CustomerModel> buyers = <CustomerModel>[].obs;
  List<SupplierModel> sellers = <SupplierModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBuyers();
    fetchSuplliers();
  }

  // Load buyers from Firestore
  Future<void> fetchBuyers() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('customers').get();
      buyers =
          snapshot.docs.map((doc) => CustomerModel.fromFirestore(doc)).toList();

      if (inventoryData != null) {
       
          selectedBuyer.value = inventoryData?.buyer;
        
      }
    } catch (e) {
      print("Error fetching buyers: $e");
    }
  }

  Future<void> fetchSuplliers() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('suppliers').get();
      sellers = querySnapshot.docs
          .map((doc) => SupplierModel.fromFirestore(doc))
          .toList();
      if (inventoryData != null) {
        selectedSeller.value = inventoryData?.seller;
      }
    } catch (e) {
      print("Error fetching buyers: $e");
    }
  }

  InventoryModel? inventoryData;
  // Set the inventory data when editing
  void setInventoryData(InventoryModel inventory) {
    inventoryData = inventory;
    print('xgxfgfgfgdfggf${inventory.seller}');
    inventoryToEdit = inventory;
    itemCodeController.text = inventory.itemCode ?? '';
    companyNameController.text = inventory.companyName ?? '';
    brandController.text = inventory.brand!;
    modelNumberController.text = inventory.modelNumber ?? '';
    configurationController.text = inventory.configuration ?? '';
    serialNumberController.text = inventory.serialNumber ?? '';
    selectedStatus.value = inventory.status![0].toUpperCase() + inventory.status!.substring(1);
    purchaseDateController.text = inventory.purchaseDate ?? '';
    purchaseAmountController.text = inventory.purchaseAmount ?? '';
   
      sellDateController.text = inventory.sellDate ?? '';
      sellAmountController.text = inventory.sellAmount ?? '';
      selectedPaidBy.value = inventory.paidBy ?? '';
    
  }

  // Save Data Method
  Future<void> saveData(String buttonType) async {
    if (buttonType.toLowerCase() == 'save') {
      if (formKey.currentState!.validate()) {
        if (inventoryToEdit != null) {
          await _updateIntemInventory(); // Call to update the existing customer
        } else {
          await _saveInventory(); // Call to save the new customer
        }
        Get.back(result: true); // Close screen and pass success
      }
    } else if (buttonType.toLowerCase() == 'save+next') {
      if (formKey.currentState!.validate()) {
        await _saveInventory(); // Save inventory data
        refresh(); // Reset form for new entry
      }
    }
  }

  // Save inventory data to Firestore
  Future<void> _saveInventory() async {
    try {
      // Parse the purchase date and convert it to a timestamp
      int purchaseTimestamp = 0; // Default value in case of failure
      if (purchaseDateController.text.isNotEmpty) {
        try {
          DateTime parsedDate = DateTime.parse(purchaseDateController.text);
          purchaseTimestamp = parsedDate.millisecondsSinceEpoch;
        } catch (e) {
          print("Error parsing purchase date: $e");
        }
      }

      InventoryModel inventory = InventoryModel(
          itemCode: itemCodeController.text,
          companyName: companyNameController.text,
          brand: brandController.text,
          modelNumber: modelNumberController.text,
          configuration: configurationController.text,
          serialNumber: serialNumberController.text,
          status: selectedStatus.value.toLowerCase(),
          purchaseAmount: purchaseAmountController.text,
          purchaseAmountNum: int.tryParse(purchaseAmountController.text) ?? 0,
          seller: selectedSeller.value,
          purchaseDate: purchaseDateController.text,
          purchaseTimestamp: purchaseTimestamp,
          createdAt: DateTime.now().millisecondsSinceEpoch);
          

      // Convert the object to JSON
      Map<String, dynamic> inventoryData = inventory.toJson();

      // Add the inventory data to Firestore
     await FirestoreCollections.inventory.add(inventoryData);
         
      print("Inventory data saved successfully.");
    } catch (e) {
      print("Error saving inventory data: $e");
    }
  }

  Future<void> _updateIntemInventory() async {
    try {
      int purchaseTimestamp = 0; // Default value in case of failure
      int sellTimestamp = 0;
      if (purchaseDateController.text.isNotEmpty) {
        try {
          DateTime parsedDate = DateTime.parse(purchaseDateController.text);
          purchaseTimestamp = parsedDate.millisecondsSinceEpoch;
        } catch (e) {
          print("Error parsing purchase date: $e");
        }
      }
      if (sellDateController.text.isNotEmpty) {
        try {
          DateTime parsedDate = DateTime.parse(sellDateController.text);
          sellTimestamp = parsedDate.millisecondsSinceEpoch;
        } catch (e) {
          print("Error parsing purchase date: $e");
        }
      }

      if (inventoryToEdit == null)
        return; // Ensure there's a customer to update

      // Get the document reference using the customer's ID
     DocumentReference inventoryRef =
          FirestoreCollections.inventory.doc(inventoryToEdit
              ?.id); // Assuming your CustomerModel has an 'id' field

      InventoryModel inventory = InventoryModel(
          itemCode: itemCodeController.text,
          companyName: companyNameController.text,
          brand: brandController.text,
          modelNumber: modelNumberController.text,
          configuration: configurationController.text,
          serialNumber: serialNumberController.text,
          status: selectedStatus.value.toLowerCase(),
          purchaseAmount: purchaseAmountController.text,
          purchaseAmountNum: int.tryParse(purchaseAmountController.text) ?? 0,
          seller: selectedSeller.value,
          purchaseDate: purchaseDateController.text,
          purchaseTimestamp: purchaseTimestamp,
          buyer: selectedBuyer.value,
          sellAmount: sellAmountController.text,
          sellAmountNum: int.tryParse(sellAmountController.text) ?? 0,
          sellDate: sellDateController.text,
          sellTimestamp: sellTimestamp,
          updatedAt: DateTime.now().millisecondsSinceEpoch,
          paidBy: selectedPaidBy.value);
      Map<String, dynamic> inventoryData = inventory.toJson();

      await inventoryRef.update(inventoryData);

      print("Customer data updated successfully.");
    } catch (e) {
      print("Error updating customer data: $e");
    } finally {}
  }

  void cancelSaving() {
    Get.back();
  }
}
