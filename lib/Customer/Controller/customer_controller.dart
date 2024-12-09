import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Customer/View/add_customer_screen.dart';
import 'package:inventoryappflutter/Add_Supplier/View/add_supplier_screen.dart';

class CustomerController extends GetxController {

  var selectedButton = 'All'.obs;
  RxBool isSearchActive = false.obs;
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
   var supplierList = [  {
        'Name': 'A001',
        'Phone_Number': '9027417888',
        'Address': 'Config1',
        'CreatedAt': 'SN001',
       
      },
      {
        'Name': 'A002',
        'Phone_Number': '4485529114',
        'Address': 'Config1',
        'CreatedAt': 'SN001',
      },
      {
        'Name': 'A003',
        'Phone_Number': '5485892247',
        'Address': 'Config1',
        'CreatedAt': 'SN001',
      },
      {
        'Name': 'A004',
        'Phone_Number': '5595158987',
        'Address': 'Config1',
        'CreatedAt': 'SN001',
      },
      {
        'Name': 'A005',
        'Phone_Number': '56699529852',
        'Address': 'Config1',
        'CreatedAt': 'SN001',
      },].obs;

       RxList<Map<String, String>> filteredCustomerList = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(filterSupplierList);
    filterSupplierList(); // Fetch or simulate fetching inventory
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // void toggleSearch() {
  //   isSearching.value = !isSearching.value; // Toggle search state
  // }

   void filterSupplierList() {
    final query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      // If the query is empty, show all items
      filteredCustomerList.assignAll(supplierList);
    } else {
      // Filter the list based on the query
     filteredCustomerList.assignAll(supplierList.where((item) {
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
