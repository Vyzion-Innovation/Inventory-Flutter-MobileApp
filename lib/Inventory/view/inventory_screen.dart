import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Inventory/Controller/inventory_controller.dart';
import 'package:inventoryappflutter/common/build_card.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/common_text_button.dart';
import 'package:inventoryappflutter/common/customTextField.dart';

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
          const Divider(),
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
          return inventoryItemCard(profile);
        },
      );
    });
  }

  Widget inventoryItemCard(dynamic profile) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: CommonCard(
      padding: const EdgeInsets.all(12),
      onTap: () {
        print("Card clicked for item code: ${profile['itemCode']}");
      },
      additionalWidgets: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           Column(children: [
        AppText('Item Code: ${profile['itemCode'] ?? ""}', 
          fontWeight: FontWeight.bold, fontSize: 14),
        const SizedBox(height: 10),
        AppText('Model Number: ${profile['ModelNumber'] ?? ""}', 
          fontWeight: FontWeight.bold, fontSize: 14),
        const SizedBox(height: 10),
        AppText('Configuration: ${profile['configuration'] ?? ""}', 
          fontWeight: FontWeight.bold, fontSize: 14),
        const SizedBox(height: 10),
        AppText('Serial Number: ${profile['serialNumber'] ?? ""}', 
          fontWeight: FontWeight.bold, fontSize: 14),
        const SizedBox(height: 10),
        AppText('Status: ${profile['status'] ?? ""}', 
          fontWeight: FontWeight.bold, fontSize: 14),
        const SizedBox(height: 10),
       
      ],
    ),
     Column(
        
          children: [
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: controller.editItem,
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 20),
              onPressed: controller.deleteItem,
            ),
          ],
        ),
        ])
    ],)
  );
}

  Widget filterButtons() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => Expanded(
              child: ElevatedButton(
                onPressed: () {
                  controller.selectedButton.value = 'All';
                  controller.fetchInventoryList(filterType: 'All');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.selectedButton.value == 'All'
                      ? AppColors.primaryColor // Use active color
                      : AppColors.greyColor, // Inactive color
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  inevontryTextStrings.btnTextALL,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            )),
        const SizedBox(width: 10),
        Obx(() => Expanded(
              child: ElevatedButton(
                onPressed: () {
                  controller.selectedButton.value = 'Stock';
                  controller.fetchInventoryList(filterType: 'Stock');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.selectedButton.value == 'Stock'
                      ? AppColors.primaryColor
                      : AppColors.greyColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  inevontryTextStrings.btnTextStock,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            )),
        const SizedBox(width: 10),
        Obx(() => Expanded(
              child: ElevatedButton(
                onPressed: () {
                  controller.selectedButton.value = 'Sell';
                  controller.fetchInventoryList(filterType: 'Sell');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.selectedButton.value == 'Sell'
                      ? AppColors.primaryColor
                      : AppColors.greyColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  inevontryTextStrings.btnTextsell,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
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
        hintText: inevontryTextStrings.Searchhint,
        controller: controller.searchController,
        borderSide: const BorderSide(color: AppColors.greyColor, width: 1.0),
      ),
    );
  }
}
