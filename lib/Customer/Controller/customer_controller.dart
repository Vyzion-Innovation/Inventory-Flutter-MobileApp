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
    searchController.addListener(_onSearchChanged);

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
  void _onSearchChanged() {
    final searchText = searchController.text.trim();
    if (searchText.isEmpty) {
      // Clear the search and fetch all customers
      fetchCustomers();
    } else {
      // Trigger search query
      fetchCustomers();
    }
  }

  /// Fetch customers with or without search filter
  Future<void> fetchCustomers({bool isNextPage = false}) async {
    try {
      if (isFetching.value) return; // Prevent duplicate fetches

      isFetching.value = true;

      String searchQuery = searchController.text.trim().toLowerCase();

      // Define the query
      Query query;

      if (searchQuery.isEmpty) {
        // Default query when no search term is entered
        query = FirebaseFirestore.instance
            .collection('customers')
            .orderBy('created_at') // Default ordering
            .limit(limit);
      } else {
        // Query with search filtering
        query = FirebaseFirestore.instance
            .collection('customers')
            .orderBy('name') // Required for search

            .startAt([searchQuery])
            .endAt(['$searchQuery\uf8ff'])
            .limit(limit);
      }

      // Apply pagination if applicable
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
    } catch (e) {
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
