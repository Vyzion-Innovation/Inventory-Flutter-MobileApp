import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Supplier/View/add_supplier_screen.dart';

class SupplierController extends GetxController {
  RxList<Map<String, dynamic>> supplierList = <Map<String, dynamic>>[
  ].obs;

  List<Map<String, dynamic>> filteredSupplierList = <Map<String, dynamic>>[].obs;
   RxBool isSearchActive = false.obs;
  FocusNode focusNode = FocusNode();

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchSuppliers();
    searchController.addListener(() {
      filterSupplierList();
    });
  }

 Future<void> fetchSuppliers() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('suppliers').get();
      List<Map<String, dynamic>> suppliers = snapshot.docs.map((doc) {
        return {
          'Name': doc['name'],
          'Phone_Number': doc['phone'],
          'Address': doc['address'],
          'CreatedAt': doc['created_at'],
        };
      }).toList();

      supplierList.assignAll(suppliers);
      filterSupplierList();
      print(supplierList);
      // filteredSupplierList.assignAll(suppliers);  
    } catch (e) {
      print("Error fetching suppliers: $e");
    }
  }
  
  void filterSupplierList() {
    final query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      // If the query is empty, show all items
      filteredSupplierList.assignAll(supplierList);
    } else {
    
     filteredSupplierList.assignAll(supplierList.where((item) {
  return (item['Name']?.toLowerCase().contains(query) ?? false);
 
         
}).toList());
 print(filteredSupplierList);
    }
  }



  void toggleSearch() {
    filterSupplierList();
  }

 void addItem() {
    Get.to(() => AddSupplierScreen());
  }
}
