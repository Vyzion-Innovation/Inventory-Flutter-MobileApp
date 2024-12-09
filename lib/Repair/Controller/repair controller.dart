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
      List<RepairModel> repairs = snapshot.docs.map((doc) => RepairModel.fromFirestore(doc))
    .toList();
      
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
  
    final searchedList = query.isEmpty
      ? repairList
      : repairList.where((item) {
          return 
                 (item.customerName?.toLowerCase().contains(query) ?? false);
      }).toList();

    if (!filteredRepairList.equals(searchedList)) {
      print('Updating Filtered Inventory List');
      filteredRepairList.assignAll(searchedList);
    }
  }

  /// Navigates to the add repair form screen
  Future<void> addItem() async {
   final result = await Get.to(() => RepairFormScreen());
     // ignore: unrelated_type_equality_checks
     if (result == true) {
      await fetchRepairList(selectedButton.value); // Refresh data if changes were made
    }
  }


 Future<void> deleteItem(RepairModel m) async {
    try {
      await FirebaseFirestore.instance
          .collection('inventories')
          .doc(m.id) // Use the document ID to delete
          .delete();
      print("Inventory deleted successfully.");
      // Optionally refresh the customer list
      await fetchRepairList(selectedButton.value);
    } catch (e) {
      print("Error deleting customer: $e");
    }
  }

}
