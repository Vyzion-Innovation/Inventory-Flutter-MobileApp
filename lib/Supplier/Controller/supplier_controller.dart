import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Repair/View/repair_screen.dart';
import 'package:inventoryappflutter/Add_Supplier/View/add_supplier_screen.dart';

class SupplierController extends GetxController {

  var selectedButton = 'All'.obs;
  var isSearching = false.obs;
  TextEditingController searchController = TextEditingController();
   var supplierList = [  {
        'Name': 'A001',
        'Phone_Number': 'MN0012',
        'Address': 'Config1',
        'CreatedAt': 'SN001',
       
      },
      {
        'Name': 'A002',
        'Phone_Number': 'MN0012',
        'Address': 'Config1',
        'CreatedAt': 'SN001',
      },
      {
        'Name': 'A003',
        'Phone Number': 'MN0012',
        'Address': 'Config1',
        'CreatedAt': 'SN001',
      },
      {
        'Name': 'A004',
        'Phone _Number': 'MN0012',
        'Address': 'Config1',
        'CreatedAt': 'SN001',
      },
      {
        'Name': 'A005',
        'Phone_Number': 'MN0012',
        'Address': 'Config1',
        'CreatedAt': 'SN001',
      },].obs;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(fetchSupplierList);
    fetchSupplierList(); // Fetch or simulate fetching inventory
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value; // Toggle search state
  }

  void fetchSupplierList({String filterType = 'All'}) {
    // Static data for testing purposes
   
   
  }

  

  void addItem() {
    Get.to(() => AddSupplierScreen());
  }

  void editItem() {
    // Placeholder for editing item logic
  }

  void deleteItem() {
    // Placeholder for deleting item logic
  }
}
