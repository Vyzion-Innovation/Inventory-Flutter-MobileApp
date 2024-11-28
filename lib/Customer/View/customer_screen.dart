import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Customer/Controller/customer_controller.dart';
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
      if (controller.supplierList.isEmpty) {
        return const Center(child: Text('No data available'));
      }
      return ListView.builder(
        itemCount: controller.supplierList.length,
        itemBuilder: (context, index) {
          final profile = controller.supplierList[index];
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
                          '${profile['Name'] ?? ""}',
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
                          '${profile['Phone_Number'] ?? ""}',
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
                          '${profile['Address'] ?? ""}',
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
                          '${profile['CreatedAt'] ?? ""}',
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
        child: CustomTextField(
          MaxLine: 1,
          hintText: inevontryTextStrings.Searchhint,
          controller: controller.searchController,
          borderSide: const BorderSide(color: AppColors.greyColor, width: 1.0),
          suffix: IconButton(
            onPressed: () {
              controller.toggleSearch();
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
