import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Customer/View/add_customer_screen.dart';
import 'package:inventoryappflutter/Add_Supplier/View/add_supplier_screen.dart';

class CustomerController extends GetxController {

  var selectedButton = 'All'.obs;
  RxBool isSearchActive = false.obs;
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
   List<Map<String, dynamic>> customerList = <Map<String, dynamic>>[ 
       ].obs;

      List<Map<String, dynamic>> filteredCustomerList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchcustomer();
    searchController.addListener(filterSupplierList);
    filterSupplierList(); // Fetch or simulate fetching inventory
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

   Future<void> fetchcustomer() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('customers').get();
      List<Map<String, dynamic>> suppliers = snapshot.docs.map((doc) {
        return {
          'Name': doc['name'],
          'Phone_Number': doc['phone'],
          'Address': doc['billing_address'],
          'CreatedAt': doc['created_at'],
        };
      }).toList();

      customerList.assignAll(suppliers);
      filterSupplierList();
      print(customerList);
      // filteredSupplierList.assignAll(suppliers);  
    } catch (e) {
      print("Error fetching suppliers: $e");
    }
  }

   void filterSupplierList() {
    final query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      // If the query is empty, show all items
      filteredCustomerList.assignAll(customerList);
    } else {
      // Filter the list based on the query
     filteredCustomerList.assignAll(customerList.where((item) {
  return (item['Name']?.toLowerCase().contains(query) ?? false);
         
}).toList());
    }
  }

  

  void addItem() {
    Get.to(() => AddCustomerScreen());
  }

  void editItem() {
    // Placeholder for editing item logic
  }

  void deleteItem() {
    // Placeholder for deleting item logic
  }
}
