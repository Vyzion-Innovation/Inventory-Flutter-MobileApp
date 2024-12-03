import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Repair/View/repair_screen.dart';
import 'package:inventoryappflutter/Repair/Model/repair_model.dart';

class RepairController extends GetxController {
  // Observables
  var filteredRepairList = <RepairModel>[].obs; // To store filtered items
  var repairList = <RepairModel>[].obs; // To store all repair items
  var selectedButton = 'All'.obs; // Tracks which filter button is active
  var isSearchActive = false.obs;

  // Controllers and focus nodes
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchRepairList();
    searchController.addListener(filterRepairList);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Fetches repair items from Firestore
  Future<void> fetchRepairList() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('repairs').get();

      // Map Firestore documents to `RepairModel` list
      List<RepairModel> repairs = snapshot.docs.map((doc) {
        return RepairModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      // Update the repair list and apply filters
      repairList.assignAll(repairs);
      filterRepairList();
    } catch (e) {
      print("Error fetching repair list: $e");
    }
  }
  void filterRepairList() {
    final query = searchController.text.trim().toLowerCase();
    final filteredByStatus = selectedButton.value == 'All'
        ? repairList
        : repairList.where((item) {
            return item.status?.toLowerCase() == selectedButton.value.toLowerCase();
          }).toList();

        final searchedList = query.isEmpty
        ? filteredByStatus
        : filteredByStatus.where((item) {
            return (item.jobNumber?.toLowerCase().contains(query) ?? false) ||
                (item.customerName?.toLowerCase().contains(query) ?? false);
          }).toList();

    if (!filteredRepairList.equals(searchedList)) {
      print('Updating Filtered Inventory List');
      filteredRepairList.assignAll(searchedList);
    }
  }

  /// Navigates to the add repair form screen
  void addItem() {
    Get.to(() => RepairFormScreen());
  }

  /// Placeholder for editing item logic
  void editItem(RepairModel repair) {
    // Navigate to the edit form screen with the repair item
    print('Edit item: ${repair.jobNumber}');
  }

  /// Placeholder for deleting item logic
  void deleteItem(RepairModel repair) {
    // Implement deletion logic
    print('Delete item: ${repair.jobNumber}');
  }
}
