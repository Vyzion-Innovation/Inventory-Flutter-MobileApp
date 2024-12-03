import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Model/supplier_model.dart';
import 'package:inventoryappflutter/Supplier/Controller/supplier_controller.dart';
import 'package:inventoryappflutter/common/build_card.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/customTextField.dart';

import '../../common/app_common_appbar.dart';

class SupllierScreen extends StatelessWidget {
  final SupplierController controller = Get.put(SupplierController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: const AppText(
            Strings.supplier,
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
    if (controller.filteredSupplierList.isEmpty) {
      return const Center(child: Text('No data available'));
    }
    return ListView.builder(
      itemCount: controller.filteredSupplierList.length,
      itemBuilder: (context, index) {
        var profile = controller.filteredSupplierList[index];
        return inventoryItemCard(profile, index);
      },
    );
  });
}

  Widget inventoryItemCard(SupplierModel profile, int index) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: CommonCard(
      padding: const EdgeInsets.all(16),
      onTap: () {
        print("Card clicked for item code");
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
                        profile.name ?? '', // Updated key
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const AppText(
                        'Phone_Number:  ',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      AppText(
                       profile.phone ?? '',  // Updated key
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const AppText(
                        'Address:  ',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      AppText(
                       profile.supplierAddress ?? '', // Updated key
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      AppText(
                        'CreatedAt:  ',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      AppText(
                        profile.createdAt.toString().split(' ')[0] ?? '' ,// Updated key
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
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () {},
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20),
                  onPressed: () {
                    // Call deleteItem with the index
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
          borderSide: const BorderSide(color: AppColors.greyColor, width: 1.0),
          prefftext: const Icon(Icons.search),
          suffix: controller.isSearchActive.value
              ? IconButton(
                  onPressed: () {
                    // Clear search and deactivate
                    controller.searchController.clear();
                    controller.isSearchActive.value = false;
                    controller.focusNode.unfocus(); // Dismiss the keyboard
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
