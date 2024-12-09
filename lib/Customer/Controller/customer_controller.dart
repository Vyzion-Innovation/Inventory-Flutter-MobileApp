import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Customer/View/add_customer_screen.dart';
import 'package:inventoryappflutter/Add_Supplier/View/add_supplier_screen.dart';
import 'package:inventoryappflutter/Model/customer_model.dart';

class CustomerController extends GetxController {

  RxBool isSearchActive = false.obs;
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  var customerList = <CustomerModel>[ 
       ].obs;

      var filteredCustomerList = <CustomerModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCustomers();
    searchController.addListener(filterCustomerList);
    filterCustomerList(); // Fetch or simulate fetching inventory
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

   Future<void> fetchCustomers() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('customers').get();
    final List<CustomerModel> customers = snapshot.docs.map((doc) => CustomerModel.fromFirestore(doc)).toList();

      customerList.assignAll(customers);
      filterCustomerList();
      print(customerList);
      // filteredSupplierList.assignAll(suppliers);  
    } catch (e) {
      print("Error fetching suppliers: $e");
    }
  }

   void filterCustomerList() {
    final query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      // If the query is empty, show all items
      filteredCustomerList.assignAll(customerList);
    } else {
      // Filter the list based on the query
     filteredCustomerList.assignAll(customerList.where((item) {
  return (item.name?.toLowerCase().contains(query) ?? false);
         
}).toList());
    }
  }

  

  void addItem() async {
    final result = await Get.to(() => AddCustomerScreen());
     // ignore: unrelated_type_equality_checks
     if (result == true) {
      await fetchCustomers(); // Refresh data if changes were made
    }

  }
  

   Future<void> deleteCustomer(CustomerModel m) async {
    try {
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(m.id) // Use the document ID to delete
          .delete();
      print("Customer deleted successfully.");
      // Optionally refresh the customer list
      await fetchCustomers(); // Ensure you have this method to fetch the updated list
    } catch (e) {
      print("Error deleting customer: $e");
    }
  }
}
