import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Inventory/Controller/inventory_controller.dart';
import 'package:inventoryappflutter/common/build_card.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/common_text_button.dart';
import 'package:inventoryappflutter/common/customTextField.dart';
import 'package:inventoryappflutter/common/filter_button.dart';

import '../../common/app_common_appbar.dart';

class InventoriesScreen extends StatelessWidget {
  final InventoriesController controller = Get.put(InventoriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: Obx(() {
            return controller.isSearching.value
                ? searchBar()
                : const AppText(
                    Strings.inventory,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  );
          }),
          isCenter: true,
          actions: [
            IconButton(
              onPressed: () {
                controller.toggleSearch();
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
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
          filterButtons(),
         
          Expanded(child: inventoryListBuilder()),
        ],
      ),
    );
  }

  Widget inventoryListBuilder() {
    return Obx(() {
      if (controller.inventoryList.isEmpty) {
        return const Center(child: Text('No data available'));
      }
      return ListView.builder(
        itemCount: controller.inventoryList.length,
        itemBuilder: (context, index) {
          final profile = controller.inventoryList[index];
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
                      AppText(
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
                      AppText(
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
                      AppText(
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
                      AppText(
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
                  color: profile['status'] == 'Available' ? Colors.green : Colors.red,
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () {
                    // Call editItem with the index and a new item code (for example purposes)
                    controller.editItem(index, 'A0001'); // Replace 'NewItemCode' with actual input
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
                label: inevontryTextStrings.btnTextALL,
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
                label: inevontryTextStrings.btnTextStock,
                isSelected: controller.selectedButton.value == 'Stock',
                onTap: () {
                  controller.selectedButton.value = 'Stock';
                  controller.fetchInventoryList(filterType: 'Stock');
                },
              ),
            )),
        const SizedBox(width: 10),
        Obx(() => Expanded(
              child: FilterButton(
                label: inevontryTextStrings.btnTextsell,
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
    return SizedBox(
      height: 50,
      child: CustomTextField(
         MaxLine:1,
        hintText: inevontryTextStrings.Searchhint,
        controller: controller.searchController,
        borderSide: const BorderSide(color: AppColors.greyColor, width: 1.0),
      ),
    );
  }
}
