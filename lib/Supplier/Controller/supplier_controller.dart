import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Supplier/View/add_supplier_screen.dart';

class SupplierController extends GetxController {
  RxList<Map<String, String>> supplierList = <Map<String, String>>[
    // Add sample supplier data for testing
    {'Name': 'Supplier A', 'Phone_Number': '1234567890', 'Address': 'Location A', 'CreatedAt': '2024-11-28'},
    {'Name': 'Supplier B', 'Phone_Number': '0987654321', 'Address': 'Location f', 'CreatedAt': '2024-11-28'},
     {'Name': 'Supplier C', 'Phone_Number': '09876514321', 'Address': 'Location d', 'CreatedAt': '2024-11-28'},
      {'Name': 'Supplier d', 'Phone_Number': '09876545321', 'Address': 'Location z', 'CreatedAt': '2024-11-28'},
       {'Name': 'Supplier E', 'Phone_Number': '09876444321', 'Address': 'Location s', 'CreatedAt': '2024-11-28'},
  ].obs;

  RxList<Map<String, String>> filteredSupplierList = <Map<String, String>>[].obs;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Initialize the filtered list with all items
    filteredSupplierList.assignAll(supplierList);
    // Listen to changes in the search text
    searchController.addListener(() {
      filterSupplierList();
    });
  }

  void filterSupplierList() {
    final query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      // If the query is empty, show all items
      filteredSupplierList.assignAll(supplierList);
    } else {
      // Filter the list based on the query
     filteredSupplierList.assignAll(supplierList.where((item) {
  return (item['Name']?.toLowerCase().contains(query) ?? false);
         
}).toList());
    }
  }

  void toggleSearch() {
    filterSupplierList();
  }

 void addItem() {
    Get.to(() => AddSupplierScreen());
  }
}
