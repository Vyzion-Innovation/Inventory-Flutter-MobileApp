import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Supplier/View/add_supplier_screen.dart';
import 'package:inventoryappflutter/Model/supplier_model.dart';

class SupplierController extends GetxController {
  var supplierList = <SupplierModel>[
  ].obs;

  var filteredSupplierList = <SupplierModel>[].obs;
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
      List<SupplierModel> suppliers = snapshot.docs.map((doc) {
        return 
         SupplierModel.fromJson(doc.data() as Map<String, dynamic>);
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
  return (item.name?.toLowerCase().contains(query) ?? false);
 
         
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
