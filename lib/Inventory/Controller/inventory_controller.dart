import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/AddInventory/View/add_inventory.dart';

class InventoriesController extends GetxController {
  var filteredInventory = [].obs; // To store filtered items
  var allInventory = [].obs; // To store all items
  var selectedButton = 'All'.obs;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(filterInventory);
    fetchInventoryList(); // Placeholder for fetching inventory
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void fetchInventoryList({String filterType = 'All'}) {
    // Placeholder for fetching inventory list
  }

  void filterInventory() {
    String query = searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      // Implement filtering logic
    } else {
      // Reset to all inventory
    }
  }

  void addItem() {
  Get.to(() => InventoryFormScreen());
}

  void editItem() {
    // Placeholder for editing item logic
  }

  void deleteItem() {
    // Placeholder for deleting item logic
  }
}