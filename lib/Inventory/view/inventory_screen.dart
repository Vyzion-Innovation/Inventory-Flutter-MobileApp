import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Inventory/View/add_inventory.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Inventory/Controller/inventory_controller.dart';
import 'package:inventoryappflutter/Inventory/view/inventory_details_screen.dart';
import 'package:inventoryappflutter/Model/inventory_model.dart';
import 'package:inventoryappflutter/common/build_card.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/customTextField.dart';
import 'package:inventoryappflutter/common/filter_button.dart';

import '../../common/app_common_appbar.dart';

class InventoriesScreen extends StatelessWidget {
  final InventoriesController controller = Get.put(InventoriesController());
 

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: CustomAppBar(
          title: const AppText(
            Strings.inventory,
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
          searchBar(),
          filterButtons(),
          Expanded(child: inventoryListBuilder()),
        ],
      ),
    );
  }

   Widget inventoryListBuilder() {
    return Obx(() {
      final inventory = controller.inventoryList;
      if (inventory.isEmpty && !controller.isFetching.value) {
        return const Center(child: Text('No data available'));
      }
      return ListView.builder(
        controller: controller.scrollController,
        itemCount: inventory.length, // Add 1 for the loader
        itemBuilder: (context, index) {
          if (index == inventory.length) {
            // Display loading indicator at the end
            return const Center(child: CircularProgressIndicator());
          }
          var profile = inventory[index];
          return inventoryItemCard(profile, index);
        },
      );
    });
  }

  Widget inventoryItemCard(InventoryModel profile, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CommonCard(
        padding: const EdgeInsets.all(16),
        onTap: () {
         Get.to(() => InventoryDetailsScreen(inventory: profile));
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
                          'Item Code:  ',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        Expanded(
                          // Wrap with Expanded to prevent overflow
                          child: AppText(
                            profile.itemCode ?? "",
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const AppText(
                          'Model Number:  ',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        Expanded(
                          // Wrap with Expanded to prevent overflow
                          child: AppText(
                            profile.modelNumber ?? "",
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const AppText(
                          'Configuration:  ',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        Expanded(
                          // Wrap with Expanded to prevent overflow
                          child: AppText(
                            profile.configuration ?? "",
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const AppText(
                          'Serial Number:  ',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        Expanded(
                          // Wrap with Expanded to prevent overflow
                          child: AppText(
                            profile.serialNumber ?? "",
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                     const SizedBox(height: 8),
                    Row(
                      children: [
                        const AppText(
                          'Purchase Amount:  ',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        Expanded(
                          // Wrap with Expanded to prevent overflow
                          child: AppText(
                            profile.purchaseAmount ?? "",
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Right column for action buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    profile.status ?? "",
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: profile.status?.toLowerCase() == 'stock'
                        ? Colors.green
                        : Colors.red,
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                     onPressed: () async {
                      final result = await Get.to(
                          () => InventoryFormScreen(inventory: profile));
                      // ignore: unrelated_type_equality_checks
                      if (result == true) {
                        await controller
                            .fetchInventories(); // Refresh data if changes were made
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
                            'Are you sure you want to delete this item?',
                        onCancel: () => Get.back(),
                        onConfirm: () {
                          controller.deleteItem(
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

  Widget filterButtons() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: controller.tabList.map((tab) {
        return Obx(() {
          return Expanded(
            child: FilterButton(
              label: tab['name'] as String, // Dynamically set the label
              isSelected: controller.selectedTab['id'] == tab['id'], // Check if tab is selected
              onTap: () {
                controller.inventoryList.clear();
                controller.selectedTab.value = tab; // Update the selected tab
                controller.fetchInventories(); // Call the appropriate fetch function
              },
            ),
          );
        });
      }).toList(),
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
            hintText: inevontryTextStrings.Searchhint,
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
                      controller.fetchInventories();
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
