import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Repair/Controller/repair%20controller.dart';
import 'package:inventoryappflutter/Model/repair_model.dart';
import 'package:inventoryappflutter/Repair/View/full_details.dart';
import 'package:inventoryappflutter/common/build_card.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/customTextField.dart';
import 'package:inventoryappflutter/common/filter_button.dart';

import '../../common/app_common_appbar.dart';

class RepairScreen extends StatelessWidget {
  final RepairController controller = Get.put(RepairController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 
                 AppText(
                    Strings.repair,
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
                   Expanded(child: repairListBuilder()),
        ],
      ),
    );
  }
  Widget repairListBuilder() {
    return Obx(() {
      if (controller.filteredRepairList.isEmpty) {
        return  Center(child:  controller.isloading.value ? CircularProgressIndicator() : Text('No data available'));
      }
      return ListView.builder(
        itemCount: controller.filteredRepairList.length,
        itemBuilder: (context, index) {
          final profile = controller.filteredRepairList[index];
          return inventoryItemCard(profile, index);
        },
      );
    });
  }
 Widget inventoryItemCard(RepairModel profile, int index) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: CommonCard(
      padding: const EdgeInsets.all(16),
      onTap: () {
        Get.to(() => RepairDetailsScreen(repair: profile));
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
                        'Customer Name:  ',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      AppText(
                        profile.customerName ?? "",
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
                          profile.model ?? "",
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const AppText(
                        'Job Number:  ',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      AppText(
                           profile.jobNumber ?? "",
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const AppText(
                        'Phone Number:  ',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      AppText(
                           profile.phone ?? "",
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
                     profile.status ?? "",
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color:    profile.status ?.toLowerCase() == 'Complete'.toLowerCase() ? AppColors.successColor : Colors.red,
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20, color: AppColors.infoColor,),
                  onPressed: () {
                   
                  },
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20, color: AppColors.warningColor,),
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
              controller.fetchRepairList(controller.selectedButton.value);
                },
              ),
            )),
        const SizedBox(width: 10),
        Obx(() => Expanded(
              child: FilterButton(
                label: repairTextStrings.btnTextRecieve,
                isSelected: controller.selectedButton.value == 'Receive',
                onTap: () {
                  controller.selectedButton.value = 'Receive';
              controller.fetchRepairList(controller.selectedButton.value); 
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
              controller.fetchRepairList(controller.selectedButton.value);
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
      child: Obx(
        () => CustomTextField(
          focusNode: controller.focusNode, // Use the controller's FocusNode
          onTap: () {
            controller.isSearchActive.value = true; // Activate search
          },
          MaxLine: 1,
          hintText: inevontryTextStrings.Searchhint,
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
