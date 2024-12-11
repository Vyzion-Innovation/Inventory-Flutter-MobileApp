import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Customer/View/add_customer_screen.dart';
import 'package:inventoryappflutter/Model/customer_model.dart';

class CustomerController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final filteredCustomerList = <CustomerModel>[].obs;
  final isFetching = false.obs;
  final isSearchActive = false.obs;

  DocumentSnapshot? lastDocument; // Tracks the last document for pagination
  final int limit = 6; // Page size for pagination

  @override
  void onInit() {
    super.onInit();

    // Initial fetch of customers
    fetchCustomers();

    // Add listener for search input
    searchController.addListener(fetchCustomers);

    // Add listener for pagination
    scrollController.addListener(() {
      if (!isFetching.value &&
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 50) {
        fetchCustomers(isNextPage: true);
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

  /// Handles search input changes
 

  /// Fetch customers with or without search filter
  Future<void> fetchCustomers({bool isNextPage = false}) async {
    try {
      if (isFetching.value) return; // Prevent duplicate fetches

      isFetching.value = true;

      String searchQuery = searchController.text.trim().toLowerCase();
      String capitalizedSearchQuery = searchQuery.isNotEmpty
        ? searchQuery[0].toUpperCase() + searchQuery.substring(1)
        : "";

      // Define the query
      Query query;

      if (searchQuery.isEmpty) {
        // Default query when no search term is entered
        query = FirebaseFirestore.instance
            .collection('customers')
            .orderBy('created_at') // Default ordering
            .limit(limit);
             if (isNextPage && lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      } else if (!isNextPage) {
        lastDocument = null; // Reset last document for new search
      }

      // Execute the query
      QuerySnapshot snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        List<CustomerModel> customers = snapshot.docs
            .map((doc) => CustomerModel.fromFirestore(doc))
            .toList();

        if (isNextPage) {
          filteredCustomerList.addAll(customers);
        } else {
          filteredCustomerList.assignAll(customers);
        }

        // Update last document for pagination
        lastDocument = snapshot.docs.last;
        } else if (!isNextPage) {
        // Clear the list if no results found in a new search
        filteredCustomerList.clear();
      }

      }
       else
        {
        // Query with search filtering
        List<Query> queries = [FirebaseFirestore.instance
            .collection('customers')
            .orderBy('name') // Required for search

            .startAt([searchQuery])
            .endAt(['$searchQuery\uf8ff'])
            .limit(limit),
            FirebaseFirestore.instance
            .collection('customers')
            .orderBy('name') // Required for search

            .startAt([capitalizedSearchQuery])
            .endAt(['$capitalizedSearchQuery\uf8ff'])
            .limit(limit)];
      

      // Apply pagination if applicable
     if (isNextPage && lastDocument != null) {
          for (int i = 0; i < queries.length; i++) {
            queries[i] = queries[i].startAfterDocument(lastDocument!);
          }
        }
      // Execute the query
     List<CustomerModel> allResults = [];
        QueryDocumentSnapshot? lastFetchedDocument;
        // Run all queries and combine results
        for (var query in queries) {
          QuerySnapshot snapshot = await query.get();
          if (snapshot.docs.isNotEmpty) {
            allResults.addAll(snapshot.docs
                .map((doc) => CustomerModel.fromFirestore(doc))
                .toList());
            lastFetchedDocument = snapshot.docs.last;
          }
          }
          
  final uniqueResults = allResults.toSet().toList();

      if (isNextPage) {
        filteredCustomerList.addAll(uniqueResults);
      } else {
        filteredCustomerList.assignAll(uniqueResults);
      }

      // Update last document for pagination
      if (lastFetchedDocument != null) {
          lastDocument = lastFetchedDocument;
        } else if (!isNextPage) {
          filteredCustomerList.clear();
        }
      }
    }
    catch (e) {
      print("Error fetching customers: $e");
    } finally {
      isFetching.value = false; // Reset fetching state
    }
  }

  /// Add a new customer
  Future<void> addItem() async {
    final result = await Get.to(() => AddCustomerScreen());
    if (result == true) {
      await fetchCustomers(); // Refresh customer list if data changed
    }
  }

  /// Delete a customer
  Future<void> deleteCustomer(CustomerModel customer) async {
    try {
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(customer.id) // Use the document ID to delete
          .delete();
      print("Customer deleted successfully.");
      await fetchCustomers(); // Refresh customer list after deletion
    } catch (e) {
      print("Error deleting customer: $e");
    }
  }
}
