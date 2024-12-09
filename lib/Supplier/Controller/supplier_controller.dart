import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Supplier/View/add_supplier_screen.dart';
import 'package:inventoryappflutter/Model/supplier_model.dart';

class SupplierController extends GetxController {
   final ScrollController scrollController = ScrollController();

  var supplierList = <SupplierModel>[
  ].obs;


   RxBool isSearchActive = false.obs;
  FocusNode focusNode = FocusNode();
  final RxBool isFetching = false.obs;
   DocumentSnapshot? lastDocument;
  final int limit = 6;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchSuppliers();

    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        // Refresh the full list when search is cleared
        fetchSuppliers(isNextPage: false);
      } else {
        // Perform search filtering
        fetchSuppliers(isNextPage: false);
      }
    });

    scrollController.addListener(() {
      if (!isFetching.value &&
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 50) {
        fetchSuppliers(isNextPage: true);
      }
    });
  }

 Future<void> fetchSuppliers({bool isNextPage = false}) async {
    try {
    if (isFetching.value) return;

    isFetching.value = true;
   
    String searchQuery = searchController.text.trim().toLowerCase();

    // Declare query variable
    Query query;

    // Determine query based on search query
    if (searchQuery.isEmpty) {
      query = FirebaseFirestore.instance
          .collection('suppliers').
                orderBy('created_at')
          .limit(limit);
    } else {
      query = FirebaseFirestore.instance
          .collection('suppliers')
          .orderBy('name')
         .orderBy('created_at') // Consistent sorting
          .startAt([searchQuery])
          .endAt(['$searchQuery\uf8ff'])
          .limit(limit);
    }

    // Handle pagination
    if (isNextPage && lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    // Execute the query
    QuerySnapshot snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      List<SupplierModel> supplier = snapshot.docs
          .map((doc) => SupplierModel.fromFirestore(doc))
          .toList();

      if (isNextPage) {
        supplierList.addAll(supplier);
      } else {
        supplierList.assignAll(supplier);
      }

      // Update last document for pagination
      lastDocument = snapshot.docs.last;
    } else if (!isNextPage) {
      // Clear the list if no results and not paginating
      supplierList.clear();
    }
  } catch (e) {
    print("Error fetching suppliers: $e");
  } finally {
    isFetching.value = false;
  }
  }





 void addItem() async {
    final result = await Get.to(() => AddSupplierScreen());
     if (result == true) {
     await fetchSuppliers(); // Refresh data if changes were made
    }
  }



   Future<void> deleteSupllier(SupplierModel m) async {
    try {
      await FirebaseFirestore.instance
          .collection('suppliers')
          .doc(m.id) // Use the document ID to delete
          .delete();
      print("Supplier deleted successfully.");
      // Optionally refresh the customer list
      await fetchSuppliers(); // Ensure you have this method to fetch the updated list
    } catch (e) {
      print("Error deleting suppliers: $e");
    }
  }
}
