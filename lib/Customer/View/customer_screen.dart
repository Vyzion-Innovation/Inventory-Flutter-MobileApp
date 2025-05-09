import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Customer/View/add_customer_screen.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Customer/Controller/customer_controller.dart';
import 'package:inventoryappflutter/Customer/View/customer_details.dart';
import 'package:inventoryappflutter/Model/customer_model.dart';
import 'package:inventoryappflutter/common/build_card.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/customTextField.dart';

import '../../common/app_common_appbar.dart';

class CustomerScreen extends StatelessWidget {
  final CustomerController controller = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: const AppText(
            Strings.customer,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          isCenter: true,
          actions: [
            IconButton(
              onPressed: () {
                controller.addItem();
              },
              icon: const Icon(
                Icons.add,
              ),
            )
          ]),
      body: Column(
        children: [
          // filterButtons(),
          searchBar(),

          Expanded(child: inventoryListBuilder()),
        ],
      ),
    );
  }

  Widget inventoryListBuilder() {
    return Obx(() {
       if (controller.filteredCustomerList.isEmpty && controller.isFetching.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.filteredCustomerList.isEmpty) {
        return const Center(child: Text('No data available'));
      }
      return ListView.builder(
           controller: controller.scrollController,
        itemCount: controller.filteredCustomerList.length,
        itemBuilder: (context, index) {
          final profile = controller.filteredCustomerList[index];
          return inventoryItemCard(profile, index);
        },
      );
    });
  }

  Widget inventoryItemCard(CustomerModel profile, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CommonCard(
        padding: const EdgeInsets.all(16),
        onTap: () {
          Get.to(() => CustomerDetailsScreen(customer: profile));
        },
        additionalWidgets: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left column for item details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const AppText(
                          'Name:  ',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        AppText(
                          profile.name ?? '',
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const AppText(
                          'Phone:  ',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        AppText(
                          '+91-${profile.phone ?? ''}',
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const AppText(
                          'Billing Address:  ',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        AppText(
                          profile.billingAddress ?? '',
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ],
                    ),
                   
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Right column for action buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    onPressed: () async {
                      final result = await Get.to(
                          () => AddCustomerScreen(customer: profile));
                      // ignore: unrelated_type_equality_checks
                      if (result == true) {
                        await controller
                            .fetchCustomers(); // Refresh data if changes were made
                      }
                    },
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: () {
                      // Confirm deletion
                      Get.defaultDialog(
                        title: 'Confirm Deletion',
                        middleText:
                            'Are you sure you want to delete this customer?',
                        onCancel: () => Get.back(),
                        onConfirm: () {
                          controller.deleteCustomer(
                              profile); // Pass the document ID here
                          Get.back(); // Close the dialog
                        },
                      );
                    },
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        height: 50,
        child: Obx(
          () => CustomTextField(
            focusNode: controller.focusNode, // Use the controller's FocusNode
            onTap: () {
              controller.isSearchActive.value = true; // Activate search
            },
            MaxLine: 1,
            hintText: repairTextStrings.SearchhintName,
            controller: controller.searchController,
            borderSide:
                const BorderSide(color: AppColors.greyColor, width: 1.0),
            prefftext: const Icon(Icons.search),
            suffix: controller.isSearchActive.value
                ? IconButton(
                    onPressed: () {
                      // Clear search and deactivate
                      controller.searchController.clear();
                      controller.isSearchActive.value = false;
                      controller.focusNode.unfocus(); // Dismiss the keyboard
                      controller.fetchCustomers();
                    },
                    icon: const Icon(Icons.cancel),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
