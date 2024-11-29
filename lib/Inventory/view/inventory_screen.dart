import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Inventory/Controller/inventory_controller.dart';
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
    final inventory = controller.filteredInventoryList; // Use the filtered list
    if (inventory.isEmpty) {
      return const Center(child: Text('No data available'));
    }
    return ListView.builder(
      itemCount: inventory.length,
      itemBuilder: (context, index) {
        final profile = inventory[index];
        return inventoryItemCard(profile, index);
      },
    );
  });
}


  Widget inventoryItemCard(Map<String, String> profile, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CommonCard(
        padding: const EdgeInsets.all(16),
        onTap: () {
          print("Card clicked for item code: ${profile['itemCode']}");
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
                        AppText(
                          '${profile['itemCode'] ?? ""}',
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
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
                        AppText(
                          '${profile['ModelNumber'] ?? ""}',
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
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
                        AppText(
                          '${profile['configuration'] ?? ""}',
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
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
                        AppText(
                          '${profile['serialNumber'] ?? ""}',
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
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
                    '${profile['status'] ?? ""}',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: profile['status']?.toLowerCase() == 'stock'
                        ? Colors.green
                        : Colors.red,
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    onPressed: () {
                      // Call editItem with the index and a new item code (for example purposes)
                      controller.editItem(index,
                          'A0001'); // Replace 'NewItemCode' with actual input
                    },
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: () {
                      // Call deleteItem with the index
                      controller.deleteItem(index);
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
      children: [
        Obx(() => Expanded(
              child: FilterButton(
                label: 'All',
                isSelected: controller.selectedButton.value == 'All',
                onTap: () {
                  controller.selectedButton.value = 'All';
                  controller.fetchInventoryList(filterType: 'All');
                },
              ),
            )),
        const SizedBox(width: 10),
        Obx(() => Expanded(
              child: FilterButton(
                label: 'Stock',
                isSelected: controller.selectedButton.value == 'Stock',
                onTap: () {
                  controller.selectedButton.value = 'Stock';
                  controller.filterInventory();
                },
              ),
            )),
        const SizedBox(width: 10),
        Obx(() => Expanded(
              child: FilterButton(
                label: 'Sell',
                isSelected: controller.selectedButton.value == 'Sell',
                onTap: () {
                  controller.selectedButton.value = 'Sell';
                  controller.fetchInventoryList(filterType: 'Sell');
                },
              ),
            )),
      ],
    ),
  );
}


  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        height: 50,
        child: CustomTextField(
         
          MaxLine: 1,
          hintText: inevontryTextStrings.Searchhint,
          controller: controller.searchController,
          borderSide: const BorderSide(color: AppColors.greyColor, width: 1.0),
          focusNode: FocusNode(),
          suffix: IconButton(
            onPressed: () {
              // controller.toggleSearch();
              // FocusNode().requestFocus();
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ),
      ),
    );
  }
}
