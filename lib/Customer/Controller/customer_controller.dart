import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Supplier/View/add_supplier_screen.dart';

class CustomerController extends GetxController {

  var selectedButton = 'All'.obs;
  var isSearching = RxBool(false);
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
