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
  final int limit = 5;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchSuppliers();

    searchController.addListener(fetchSuppliers);

    scrollController.addListener(() {
      if (!isFetching.value &&
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 50) {
            fetchSuppliers(isNextPage: true);
      }
    });
  }  
 @override
  void onClose() {
      searchController.dispose();
       scrollController.dispose();
        focusNode.dispose();
    super.onClose();
  }


 Future<void> fetchSuppliers({bool isNextPage = false}) async {
    try {
    if (isFetching.value) return;

    isFetching.value = true;
   
    String searchQuery = searchController.text.trim().toLowerCase();
    String capitalizedSearchQuery = searchQuery.isNotEmpty
        ? searchQuery[0].toUpperCase() + searchQuery.substring(1)
        : "";

    // Declare query variable
    Query query;

    // Determine query based on search query
    if (searchQuery.isEmpty) {
      query = FirebaseFirestore.instance
          .collection('suppliers').
                orderBy('created_at')
          .limit(limit);
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
    } else {
     List<Query> queries = [FirebaseFirestore.instance
          .collection('suppliers')
          .orderBy('name')
         .orderBy('created_at') // Consistent sorting
          .startAt([searchQuery])
          .endAt(['$searchQuery\uf8ff'])
          .limit(limit),
          FirebaseFirestore.instance
          .collection('suppliers')
          .orderBy('name')
         .orderBy('created_at') // Consistent sorting
          .startAt([capitalizedSearchQuery])
          .endAt(['$capitalizedSearchQuery\uf8ff'])
          .limit(limit),
          ];
    

    // Handle pagination
      if (isNextPage && lastDocument != null) {
          for (int i = 0; i < queries.length; i++) {
            queries[i] = queries[i].startAfterDocument(lastDocument!);
          }
        }

    // Execute the query
    List<SupplierModel> allResults = [];
        QueryDocumentSnapshot? lastFetchedDocument;
        // Run all queries and combine results
        for (var query in queries) {
          QuerySnapshot snapshot = await query.get();
          if (snapshot.docs.isNotEmpty) {
            allResults.addAll(snapshot.docs
                .map((doc) => SupplierModel.fromFirestore(doc))
                .toList());
            lastFetchedDocument = snapshot.docs.last;
          }
        }

final uniqueResults = allResults.toSet().toList();

      if (isNextPage) {
        supplierList.addAll(uniqueResults);
      } else {
        supplierList.assignAll(uniqueResults);
      }

      // Update last document for pagination
      if (lastFetchedDocument != null) {
          lastDocument = lastFetchedDocument;
        } else if (!isNextPage) {
          supplierList.clear();
        }
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
      await fetchSuppliers(); 
    } catch (e) {
      print("Error deleting suppliers: $e");
    }
  }
}
