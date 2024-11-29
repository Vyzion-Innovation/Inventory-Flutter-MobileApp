import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Repair/View/repair_screen.dart';

class RepairController extends GetxController {
  var filteredRepair = [].obs; // To store filtered items
  var allRepairList = [].obs; // To store all items
  var selectedButton = 'All'.obs;
  var isSearchActive = false.obs;
  FocusNode focusNode = FocusNode();
  RxList<Map<String, String>> filteredRepairList = <Map<String, String>>[].obs;
  TextEditingController searchController = TextEditingController();
  var repairList = [
    {
      'itemCode': 'A009',
      'ModelNumber': 'MN0012',
      'configuration': 'Config1',
      'serialNumber': 'SN001',
      'status': 'Complete',
      'date' : '12-04-00245'
    },
    {
      'itemCode': 'A002',
      'ModelNumber': 'MN002',
      'configuration': 'Config2',
      'serialNumber': 'SN002',
      'status': 'Recieve',
       'date' : '12-04-00245'
    },
    {
      'itemCode': 'A003',
      'ModelNumber': 'MN003',
      'configuration': 'Config3',
      'serialNumber': 'SN003',
      'status': 'Complete',
       'date' : '12-04-00245'
    },
    {
      'itemCode': 'A004',
      'ModelNumber': 'MN004',
      'configuration': 'Config4',
      'serialNumber': 'SN004',
      'status': 'recieve',
       'date' : '12-04-00245'
    },
    {
      'itemCode': 'A006',
      'ModelNumber': 'MN005',
      'configuration': 'Config5',
      'serialNumber': 'SN005',
      'status': 'Recieve',
       'date' : '12-04-00245'
    },
     {
      'itemCode': 'A007',
      'ModelNumber': 'MN006',
      'configuration': 'Config6',
      'serialNumber': 'SN006',
      'status': 'Complete',
       'date' : '12-04-00245'
    },
     {
      'itemCode': 'A008',
      'ModelNumber': 'MN007',
      'configuration': 'Config7',
      'serialNumber': 'SN007',
      'status': 'Recieve',
       'date' : '12-04-00245'
    },
     {
      'itemCode': 'A009',
      'ModelNumber': 'MN008',
      'configuration': 'Config8',
      'serialNumber': 'SN008',
      'status': 'Complete',
       'date' : '12-04-00245'
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(filterRepairList);
    filterRepairList(); // Fetch or simulate fetching inventory
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void fetchRepairList({String filterType = 'All'}) {
    // Static data for testing purposes
  }

  void filterRepairList() {
    final query = searchController.text.trim().toLowerCase();
    final currentList = selectedButton.value == 'All'
        ? repairList
        : repairList
            .where((item) =>
                item['status']?.toLowerCase() ==
                selectedButton.value.toLowerCase())
            .toList();
    final searched = query.isEmpty
        ? currentList
        : currentList.where((item) {
            return (item['itemCode']?.toLowerCase().contains(query) ?? false);
          }).toList();

    if (!filteredRepairList.equals(searched)) {
      print('Updating Filtered Inventory List');
      filteredRepairList.assignAll(searched);
    }
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
