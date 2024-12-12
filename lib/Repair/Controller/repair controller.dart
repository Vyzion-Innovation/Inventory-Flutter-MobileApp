import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Repair/View/repair_screen.dart';
import 'package:inventoryappflutter/Model/repair_model.dart';

class RepairController extends GetxController {
  // Observables
  ScrollController scrollController = ScrollController();

  var filteredRepairList = <RepairModel>[].obs; // To store filtered items
  var repairList = <RepairModel>[].obs; // To store all repair items
  var selectedButton = 'All'.obs; // Tracks which filter button is active
  var isSearchActive = false.obs;
  var count = 0.obs;
  var isloading = false.obs;

  // Controllers and focus nodes
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  DocumentSnapshot? lastDocument;
  var isFetching = false.obs;
  int limit = 4; // N

  var tabList = [
    {'id': 1, 'name': 'All'},
    {'id': 2, 'name': 'Receive'},
    {'id': 3, 'name': 'Complete'},
  ].obs;

  RxMap<String, dynamic> selectedTab = RxMap({'id': 1, 'name': 'All'});

  List<String> selectedTabStatus() {
    switch (selectedTab['id']) {
      case 2:
        return ['receive'];
      case 3:
        return ['complete'];
      default:
        return ['receive', 'complete'];
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Initial fetch for the default selected button value
    fetchRepairList();
    searchController.addListener(fetchRepairList);
    scrollController.addListener(() {
      if (!isFetching.value && // Avoid multiple triggers
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 50) {
        fetchRepairList(isNextPage: true); // Trigger pagination
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

  /// Fetches repair items from Firestore based on selected button
  Future<void> fetchRepairList({bool isNextPage = false}) async {
    try {
      if (isFetching.value) return;

      isFetching.value = true;
      var status = selectedTabStatus();
      String searchQuery = searchController.text.trim().toLowerCase();

      // Declare query variable
      Query query;
      String capitalizedSearchQuery = searchQuery.isNotEmpty
          ? searchQuery[0].toUpperCase() + searchQuery.substring(1)
          : "";

      // Determine query based on search query
      if (searchQuery.isEmpty) {
        query = FirebaseFirestore.instance
            .collection('repairs')
            .where('status', whereIn: status)
            // .orderBy('job_number')
            .orderBy('created_at', descending: true)
            .limit(limit);
        if (isNextPage && lastDocument != null) {
          query = query.startAfterDocument(lastDocument!);
        }

        // Execute the query
        QuerySnapshot snapshot = await query.get();

        if (snapshot.docs.isNotEmpty) {
          List<RepairModel> repairs = snapshot.docs
              .map((doc) => RepairModel.fromFirestore(doc))
              .toList();

          if (isNextPage) {
            repairList.addAll(repairs);
          } else {
            repairList.assignAll(repairs);
          }

          // Update last document for pagination
          lastDocument = snapshot.docs.last;
        } else if (!isNextPage) {
          // Clear the list if no results and not paginating
          repairList.clear();
        }
      } else {
        List<Query> queries = [
          FirebaseFirestore.instance
              .collection('repairs')
              .where('status', whereIn: status)
              .orderBy('job_number') // Required for search
              .orderBy('created_at') // Consistent sorting
              .startAt([searchQuery]).endAt(['$searchQuery\uf8ff']).limit(
                  limit),
          FirebaseFirestore.instance
              .collection('repairs')
              .where('status', whereIn: status)
              .orderBy('job_number') // Required for search
              .orderBy('created_at') // Consistent sorting
              .startAt([capitalizedSearchQuery]).endAt(
                  [capitalizedSearchQuery + '\uf8ff']).limit(limit)
        ];

        if (isNextPage && lastDocument != null) {
          for (int i = 0; i < queries.length; i++) {
            queries[i] = queries[i].startAfterDocument(lastDocument!);
          }
        }

        // Execute the query
        List<RepairModel> allResults = [];
        QueryDocumentSnapshot? lastFetchedDocument;
        // Run all queries and combine results
        for (var query in queries) {
          QuerySnapshot snapshot = await query.get();
          if (snapshot.docs.isNotEmpty) {
            allResults.addAll(snapshot.docs
                .map((doc) => RepairModel.fromFirestore(doc))
                .toList());
            lastFetchedDocument = snapshot.docs.last;
          }
        }
        final uniqueResults = allResults.toSet().toList();

        if (isNextPage) {
          repairList.addAll(uniqueResults);
        } else {
          repairList.assignAll(uniqueResults);
        }

        // Update last document for pagination
        if (lastFetchedDocument != null) {
          lastDocument = lastFetchedDocument;
        } else if (!isNextPage) {
          repairList.clear();
        }
      }

      // Handle pagination
    } catch (e) {
      print("Error fetching repairlist: $e");
    } finally {
      isFetching.value = false;
    }
  }

  /// Navigates to the add repair form screen
  Future<void> addItem() async {
    final result = await Get.to(() => RepairFormScreen());
    // ignore: unrelated_type_equality_checks
    if (result == true) {
      await fetchRepairList(); // Refresh data if changes were made
    }
  }

  Future<void> deleteItem(RepairModel m) async {
    try {
      await FirebaseFirestore.instance
          .collection('repairs')
          .doc(m.id) // Use the document ID to delete
          .delete();
      print("repairs deleted successfully.");
      // Optionally refresh the customer list
      await fetchRepairList();
    } catch (e) {
      print("Error deleting customer: $e");
    }
  }
}
