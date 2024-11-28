import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/AddInventory/View/add_inventory.dart';

class InventoriesController extends GetxController {
  var filteredInventory = [].obs; // To store filtered items
  var allInventory = [].obs; // To store all items
  var selectedButton = 'All'.obs;
  var isSearching = false.obs;
  TextEditingController searchController = TextEditingController();
   var inventoryList = <Map<String, String>> [  {
        'itemCode': 'A001',
        'ModelNumber': 'MN0012',
        'configuration': 'Config1',
        'serialNumber': 'SN001',
        'status': 'Available',
      },
      {
        'itemCode': 'A002',
        'ModelNumber': 'MN002',
        'configuration': 'Config2',
        'serialNumber': 'SN002',
        'status': 'Sold',
      },
      {
        'itemCode': 'A003',
        'ModelNumber': 'MN003',
        'configuration': 'Config3',
        'serialNumber': 'SN003',
        'status': 'Available',
      },
      {
        'itemCode': 'A004',
        'ModelNumber': 'MN004',
        'configuration': 'Config4',
        'serialNumber': 'SN004',
        'status': 'Out of stock',
      },
      {
        'itemCode': 'A005',
        'ModelNumber': 'MN005',
        'configuration': 'Config5',
        'serialNumber': 'SN005',
        'status': 'Sold',
      },].obs;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(filterInventory);
    fetchInventoryList(); // Fetch or simulate fetching inventory
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value; // Toggle search state
  }

  void fetchInventoryList({String filterType = 'All'}) {
    // Static data for testing purposes
   
   
  }

  void filterInventory() {
   
  }

  void addItem() {
    Get.to(() => InventoryFormScreen());
  }

 void editItem(int index, String newItemCode) {
    if (index >= 0 && index < inventoryList.length) {
      // Create a new list with the updated item
      var updatedList = List<Map<String, String>>.from(inventoryList);
      updatedList[index]['itemCode'] = newItemCode; // Update the item code
      inventoryList.assignAll(updatedList); // Assign the new list to the observable list
    }
  }

  void deleteItem(int index) {
    if (index >= 0 && index < inventoryList.length) {
      inventoryList.removeAt(index); // Remove the item at the specified index
    }
  }

}
