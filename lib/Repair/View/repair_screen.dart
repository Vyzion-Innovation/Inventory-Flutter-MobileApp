import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Inventory/Controller/inventory_controller.dart';
import 'package:inventoryappflutter/Repair/Controller/repair%20controller.dart';
import 'package:inventoryappflutter/common/build_card.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/common_text_button.dart';
import 'package:inventoryappflutter/common/customTextField.dart';
import 'package:inventoryappflutter/common/filter_button.dart';

import '../../common/app_common_appbar.dart';

class RepairScreen extends StatelessWidget {
  final RepairController controller = Get.put(RepairController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: Obx(() {
            return controller.isSearching.value
                ? searchBar()
                : const AppText(
                    Strings.repair,
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
      if (controller.repairList.isEmpty) {
        return const Center(child: Text('No data available'));
      }
      return ListView.builder(
        itemCount: controller.repairList.length,
        itemBuilder: (context, index) {
          final profile = controller.repairList[index];
          return inventoryItemCard(profile);
        },
      );
    });
  }

  Widget inventoryItemCard(dynamic profile) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
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
                  AppText('Job No.: ${profile['itemCode'] ?? ""}', 
                      fontWeight: FontWeight.bold, fontSize: 16),
                  const SizedBox(height: 8),
                  AppText('Name: ${profile['ModelNumber'] ?? ""}', 
                      fontWeight: FontWeight.bold, fontSize: 14),
                  const SizedBox(height: 8),
                  AppText('Phone No.: ${profile['configuration'] ?? ""}', 
                      fontWeight: FontWeight.bold, fontSize: 14),
                  const SizedBox(height: 8),
                  AppText('Issue: ${profile['serialNumber'] ?? ""}', 
                      fontWeight: FontWeight.bold, fontSize: 14),
                  const SizedBox(height: 8),
                  AppText('Estimated Cost: ${profile['status'] ?? ""}', 
                      fontWeight: FontWeight.bold, fontSize: 14),
                       AppText('Model.: ${profile['configuration'] ?? ""}', 
                      fontWeight: FontWeight.bold, fontSize: 14),
                  const SizedBox(height: 8),
                  AppText('Status: ${profile['serialNumber'] ?? ""}', 
                      fontWeight: FontWeight.bold, fontSize: 14),
                  const SizedBox(height: 8),
                  AppText('Created At: ${profile['status'] ?? ""}', 
                      fontWeight: FontWeight.bold, fontSize: 14),
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
                  onPressed: controller.editItem,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20),
                  onPressed: controller.deleteItem,
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
                label: repairTextStrings.btnTextALL,
                isSelected: controller.selectedButton.value == 'All',
                onTap: () {
                  controller.selectedButton.value = 'All';
                  controller.fetchRepairList(filterType: 'All');
                },
              ),
            )),
        const SizedBox(width: 10),
        Obx(() => Expanded(
              child: FilterButton(
                label: repairTextStrings.btnTextRecieve,
                isSelected: controller.selectedButton.value == 'Recieve',
                onTap: () {
                  controller.selectedButton.value = 'Recieve';
                  controller.fetchRepairList(filterType: 'Recieve');
                },
              ),
            )),
        const SizedBox(width: 10),
        Obx(() => Expanded(
              child: FilterButton(
                label: repairTextStrings.btnTextcomplete,
                isSelected: controller.selectedButton.value == 'Complete',
                onTap: () {
                  controller.selectedButton.value = 'Complete';
                  controller.fetchRepairList(filterType: 'Complete');
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
        hintText: inevontryTextStrings.Searchhint,
        controller: controller.searchController,
        borderSide: const BorderSide(color: AppColors.greyColor, width: 1.0),
      ),
    );
  }
}
