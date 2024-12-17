import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Inventory/View/add_inventory.dart';
import 'package:inventoryappflutter/Model/inventory_model.dart';

class InventoriesController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final RxList<InventoryModel> inventoryList = <InventoryModel>[].obs;
  final RxList<InventoryModel> filteredInventoryList = <InventoryModel>[].obs;
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final RxBool isFetching = false.obs;
  final RxBool isSearchActive = false.obs;

  DocumentSnapshot? lastDocument;
  final int limit = 6;

  final RxList<Map<String, dynamic>> tabList = [
    {'id': 1, 'name': 'All'},
    {'id': 2, 'name': 'Stock'},
    {'id': 3, 'name': 'Sell'},
  ].obs;

  final RxMap<String, dynamic> selectedTab = RxMap({'id': 1, 'name': 'All'});

  @override
  void onInit() {
    super.onInit();
    fetchInventories();

    searchController.addListener(fetchInventories);

    scrollController.addListener(() {
      if (!isFetching.value &&
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 50) {
        fetchInventories(isNextPage: true);
      }
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.dispose();

    focusNode.dispose(); // Dispose FocusNode
    super.onClose();
  }
  
   @override
  void onReady() {
    super.onReady();
    fetchInventories(); // Fetch when the page is ready
  }


  List<String> selectedTabStatus() {
    switch (selectedTab['id']) {
      case 2:
        return ['stock'];
      case 3:
        return ['sell'];
      default:
        return ['stock', 'sell'];
    }
  }

 Future<void> fetchInventories({bool isNextPage = false}) async {
  try {
    if (isFetching.value) return;

    isFetching.value = true;
    var status = selectedTabStatus();
    String searchQuery = searchController.text.trim().toLowerCase();

    Query query;
    String capitalizedSearchQuery = searchQuery.isNotEmpty
        ? searchQuery[0].toUpperCase() + searchQuery.substring(1)
        : "";

    if (searchQuery.isEmpty) {
      query = FirebaseFirestore.instance
          .collection('inventories')
          .where('status', whereIn: status)
          
           .orderBy('created_at', descending: true)
          .limit(limit);

      if (isNextPage && lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }

      QuerySnapshot snapshot = await query.get();
      if (snapshot.docs.isNotEmpty) {
        List<InventoryModel> allResults = snapshot.docs
            .map((doc) => InventoryModel.fromFirestore(doc))
            .toList();

        if (isNextPage) {
          inventoryList.addAll(allResults);
        } else {
          inventoryList.assignAll(allResults);
        }

        lastDocument = snapshot.docs.last;
      } else if (!isNextPage) {
        inventoryList.clear();
      }
    } else {
      List<Query> queries = [
        FirebaseFirestore.instance
            .collection('inventories')
            .where('status', whereIn: status)
            .orderBy('item_code')
            .startAt([searchQuery]).endAt([searchQuery + '\uf8ff']).limit(limit),
        FirebaseFirestore.instance
            .collection('inventories')
            .where('status', whereIn: status)
            .orderBy('serial_number')
            .startAt([searchQuery]).endAt([searchQuery + '\uf8ff']).limit(limit),
      ];

      if (isNextPage && lastDocument != null) {
        for (int i = 0; i < queries.length; i++) {
          queries[i] = queries[i].startAfterDocument(lastDocument!);
        }
      }

      List<InventoryModel> allResults = [];
      Set<String> seenIds = {};
      QueryDocumentSnapshot? lastFetchedDocument;

      for (var query in queries) {
        QuerySnapshot snapshot = await query.get();
        if (snapshot.docs.isNotEmpty) {
          for (var doc in snapshot.docs) {
            if (!seenIds.contains(doc.id)) {
              allResults.add(InventoryModel.fromFirestore(doc));
              seenIds.add(doc.id);
            }
          }
          lastFetchedDocument = snapshot.docs.last;
        }
      }

      if (isNextPage) {
        inventoryList.addAll(allResults);
      } else {
        inventoryList.assignAll(allResults);
      }

      if (lastFetchedDocument != null) {
        lastDocument = lastFetchedDocument;
      } else if (!isNextPage) {
        inventoryList.clear();
      }
    }
  } catch (e) {
    print("Error fetching inventory: $e");
  } finally {
    isFetching.value = false;
  }
}


  Future<void> addItem() async {
    final result = await Get.to(() => InventoryFormScreen());
    if (result == true) {
      fetchInventories();
    }
  }

  Future<void> deleteItem(InventoryModel m) async {
    try {
      await FirebaseFirestore.instance
          .collection('inventories')
          .doc(m.id)
          .delete();
      inventoryList.remove(m); // Remove item locally for instant feedback
    } catch (e) {
      print("Error deleting inventory: $e");
    }
  }
}
