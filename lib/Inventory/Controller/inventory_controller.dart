import 'dart:ffi';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Inventory/View/add_inventory.dart';

class InventoriesController extends GetxController {
  RxList<Map<String, String>> filteredInventoryList =
      <Map<String, String>>[].obs;
  TextEditingController searchController = TextEditingController();
  var selectedButton = 'All'.obs; // Tracks the selected filter button
  RxBool isSearchActive = false.obs;
  FocusNode focusNode = FocusNode();
  var inventoryList = <Map<String, String>>[
    {
      'itemCode': 'A001',
      'ModelNumber': 'MN0012',
      'configuration': 'Config1',
      'serialNumber': 'SN001',
      'status': 'Sell',
    },
    {
      'itemCode': 'A002',
      'ModelNumber': 'MN002',
      'configuration': 'Config2',
      'serialNumber': 'SN002',
      'status': 'Stock',
    },
    {
      'itemCode': 'A003',
      'ModelNumber': 'MN003',
      'configuration': 'Config3',
      'serialNumber': 'SN003',
      'status': 'Sell',
    },
    {
      'itemCode': 'A004',
      'ModelNumber': 'MN004',
      'configuration': 'Config4',
      'serialNumber': 'SN004',
      'status': 'Stock',
    },
    {
      'itemCode': 'A005',
      'ModelNumber': 'MN005',
      'configuration': 'Config5',
      'serialNumber': 'SN005',
      'status': 'Sell',
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();

    searchController.addListener(filterInventory);
    filterInventory(); // Initialize with all data
  }

  @override
  void onClose() {
    searchController.dispose();

    super.onClose();
  }

  void fetchInventoryList({String filterType = 'All'}) {
    // List<Map<String, String>> filtered = [];
    // if (filterType == 'All') {
    //   filtered = inventoryList;
    // } else {
    //   filtered = inventoryList.where((item) => item['status'] == filterType).toList();
    // }

    // Only update the list if it has changed
    // if (!filteredInventoryList.equals(filtered)) {
    //   filteredInventoryList.assignAll(filtered);
    // }

    filterInventory();
  }

  void filterInventory() {
    final query = searchController.text.trim().toLowerCase();
    print('Selected Button: ${selectedButton.value}');
    print('Search Query: $query');

    final currentList = selectedButton.value == 'All'
        ? inventoryList
        : inventoryList
            .where((item) => item['status'] == selectedButton.value)
            .toList();

    final searched = query.isEmpty
        ? currentList
        : currentList.where((item) {
            return (item['itemCode']?.toLowerCase().contains(query) ?? false) ||
                (item['ModelNumber']?.toLowerCase().contains(query) ?? false);
          }).toList();

    if (!filteredInventoryList.equals(searched)) {
      print('Updating Filtered Inventory List');
      filteredInventoryList.assignAll(searched);
    }
  }

  void addItem() {
    Get.to(() => InventoryFormScreen());
  }

  void editItem(int index, String newItemCode) {
    // Example edit logic
    inventoryList[index]['itemCode'] = newItemCode;
    // fetchInventoryList(filterType: selectedButton.value); // Update the view
  }

  void deleteItem(int index) {
    inventoryList.removeAt(index);
    // fetchInventoryList(filterType: selectedButton.value); // Update the view
  }
}
