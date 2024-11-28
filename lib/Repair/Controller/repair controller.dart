import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Repair/View/repair_screen.dart';

class RepairController extends GetxController {
  var filteredRepair = [].obs; // To store filtered items
  var allRepairList = [].obs; // To store all items
  var selectedButton = 'All'.obs;
  var isSearching = false.obs;
  TextEditingController searchController = TextEditingController();
   var repairList = [  {
        'itemCode': 'A009',
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
    searchController.addListener(filterRepairList);
    fetchRepairList(); // Fetch or simulate fetching inventory
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value; // Toggle search state
  }

  void fetchRepairList({String filterType = 'All'}) {
    // Static data for testing purposes
   
   
  }

  void filterRepairList() {
   
  }

  void addItem() {
    Get.to(() => RepairFormScreen());
  }

  void editItem() {
    // Placeholder for editing item logic
  }

  void deleteItem() {
    // Placeholder for deleting item logic
  }
}
