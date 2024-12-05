import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Inventory/View/add_inventory.dart';
import 'package:inventoryappflutter/Model/inventory_model.dart';

class InventoriesController extends GetxController {
 var filteredInventoryList =
      <InventoryModel>[].obs;
  TextEditingController searchController = TextEditingController();
  var selectedButton = 'All'.obs; // Tracks the selected filter button
  RxBool isSearchActive = false.obs;
  FocusNode focusNode = FocusNode();
 var inventoryList = <InventoryModel>[
    
].obs;

  @override
  void onInit() {
    super.onInit();
fetchInventory();
    searchController.addListener(filterInventory);
    filterInventory(); // Initialize with all data
  }

  @override
  void onClose() {
    searchController.dispose();

    super.onClose();
  }


  Future<void> fetchInventory() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('inventories').get();
      List<InventoryModel> inventories = snapshot.docs
    .map((doc) => InventoryModel.fromFirestore(doc))
    .toList();

      inventoryList.assignAll(inventories);
      filterInventory();
     
    } catch (e) {
      print("Error fetching inventory: $e");
    }
  }

  void filterInventory() {
    final query = searchController.text.trim().toLowerCase();
    print('Selected Button: ${selectedButton.value}');
    print('Search Query: $query');

    final currentList = selectedButton.value == 'All'
        ? inventoryList
        : inventoryList
            .where((item) => item.status?.toLowerCase() == selectedButton.value.toLowerCase())
            .toList();

   final searched = query.isEmpty
        ? currentList
        : currentList.where((item) {
            return (item.itemCode?.toLowerCase().contains(query) ?? false) ||
                (item.modelNumber?.toLowerCase().contains(query) ?? false);
          }).toList();

    if (!filteredInventoryList.equals(searched)) {
      print('Updating Filtered Inventory List');
      filteredInventoryList.assignAll(searched);
    }
  }

  Future<void> addItem() async {
   final result = await Get.to(() => InventoryFormScreen());
     // ignore: unrelated_type_equality_checks
     if (result == true) {
      await fetchInventory(); // Refresh data if changes were made
    }
  }

  void editItem(int index, String newItemCode) {
    // Example edit logic
  
    // fetchInventoryList(filterType: selectedButton.value); // Update the view
  }

  Future<void> deleteItem(InventoryModel m) async {
    try {
      await FirebaseFirestore.instance
          .collection('inventories')
          .doc(m.id) // Use the document ID to delete
          .delete();
      print("Inventory deleted successfully.");
      // Optionally refresh the customer list
      await fetchInventory(); // Ensure you have this method to fetch the updated list
    } catch (e) {
      print("Error deleting customer: $e");
    }
  }
}
