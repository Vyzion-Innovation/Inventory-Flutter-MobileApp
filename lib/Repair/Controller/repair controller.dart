import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inventoryappflutter/Add_Repair/View/repair_screen.dart';
import 'package:inventoryappflutter/Model/repair_model.dart';

class RepairController extends GetxController {
  // Observables
  var filteredRepairList = <RepairModel>[].obs; // To store filtered items
  var repairList = <RepairModel>[].obs; // To store all repair items
  var selectedButton = 'All'.obs; // Tracks which filter button is active
  var isSearchActive = false.obs;
  var count = 0.obs;
  var isloading = false.obs;

  // Controllers and focus nodes
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Initial fetch for the default selected button value
    fetchRepairList(selectedButton.value);
    searchController.addListener(filterRepairList);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Fetches repair items from Firestore based on selected button
  Future<void> fetchRepairList(String status) async {
    isloading.value = true;
    try {
      Query query = FirebaseFirestore.instance.collection('repairs');
      
      // Apply a filter based on the selected button
      if (status.toLowerCase() == 'Receive'.toLowerCase()) {
        query = query.where('status', isEqualTo: 'Receive'.toLowerCase());
      } else if (status.toLowerCase() == 'Complete'.toLowerCase()) {
        query = query.where('status', isEqualTo: 'Complete'.toLowerCase());
      }
          
      QuerySnapshot snapshot = await query.get();

      // Map Firestore documents to `RepairModel` list
      List<RepairModel> repairs = snapshot.docs.map((doc) {
        return RepairModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      
      count.value = repairs.length;
      // Update the repair list and apply filters
      repairList.assignAll(repairs);
      filterRepairList(); // Call to filter based on search input
       isloading.value = false;
    } catch (e) {
       isloading.value = false;
      print("Error fetching repair list: $e");
    }
  }

  void filterRepairList() {
    final query = searchController.text.trim().toLowerCase();
    
    // Filter based on the selected button and search query
    final filteredByStatus = repairList; // All repairs already fetched based on button

    final searchedList = query.isEmpty
      ? filteredByStatus
      : filteredByStatus.where((item) {
          return 
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
  void editItem() {
    // Placeholder implementation
  }

  /// Placeholder for deleting item logic
  void deleteItem() {
    // Placeholder implementation
  }

}
