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
    focusNode.dispose(); // Dispose FocusNode
    super.onClose();
  }

  List<String> selectedTabStatus() {
    switch (selectedTab['id']) {
      case 2:
        return ['Stock'];
      case 3:
        return ['Sell'];
      default:
        return ['Stock', 'Sell'];
    }
  }

 Future<void> fetchInventories({bool isNextPage = false}) async {
  try {
    if (isFetching.value) return;

    isFetching.value = true;
    var status = selectedTabStatus();
    String searchQuery = searchController.text.trim().toLowerCase();

    // Declare query variable
    Query query;

    // Determine query based on search query
    if (searchQuery.isEmpty) {
      query = FirebaseFirestore.instance
          .collection('inventories')
          .where('status', whereIn: status)
          .orderBy('item_code').
          orderBy('created_at')
          .limit(limit);
    } else {
      query = FirebaseFirestore.instance
          .collection('inventories')
          .where('status', whereIn: status)
          .orderBy('item_code') // Required for search
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
      List<InventoryModel> inventories = snapshot.docs
          .map((doc) => InventoryModel.fromFirestore(doc))
          .toList();

      if (isNextPage) {
        inventoryList.addAll(inventories);
      } else {
        inventoryList.assignAll(inventories);
      }

      // Update last document for pagination
      lastDocument = snapshot.docs.last;
    } else if (!isNextPage) {
      // Clear the list if no results and not paginating
      inventoryList.clear();
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
      await FirebaseFirestore.instance.collection('inventories').doc(m.id).delete();
      inventoryList.remove(m); // Remove item locally for instant feedback
    } catch (e) {
      print("Error deleting inventory: $e");
    }
  }
}
