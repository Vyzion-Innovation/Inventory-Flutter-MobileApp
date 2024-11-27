import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inventoryappflutter/AddInventory/View/add_inventory.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Extension/form_validator.dart';
import 'package:inventoryappflutter/Inventory/Controller/inventory_controller.dart';
import 'package:inventoryappflutter/common/app_common_appbar.dart';
import 'package:inventoryappflutter/common/app_common_button.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/common_text_button.dart';
import 'package:inventoryappflutter/common/customTextField.dart';

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
      body: ListView(
        children: [
          filterButtons(),
          Divider(),
          inventoryListView(),
          Divider(),
         
        ],
      ),
    );
  }

  Widget inventoryListView() {
    return SizedBox(
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
           SizedBox(width: 10,),
          AppText('Item code', fontWeight: FontWeight.bold , fontSize: 12,),
         SizedBox(width: 10,),
          AppText('Model no.', fontWeight: FontWeight.bold, fontSize: 12,),
           SizedBox(width: 10,),
          AppText('Configuration', fontWeight: FontWeight.bold, fontSize: 12,),
           SizedBox(width: 10,),
          AppText('Serial no.', fontWeight: FontWeight.bold, fontSize: 12,),
           SizedBox(width: 10,),
          AppText('Status', fontWeight: FontWeight.bold ,fontSize: 12,),
           SizedBox(width: 10,),
          AppText('Actions', fontWeight: FontWeight.bold ,fontSize: 12,),
        ],
      ),
    );
  }

  Widget filterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 10,
        ),
        Obx(() => Expanded(
              child: CustomTextButton(
                title: 'All',
                onPressed: () {
                  controller.selectedButton.value = 'All';
                  controller.fetchInventoryList(filterType: 'All');
                },
                textColor: Colors.white,
                selected: controller.selectedButton.value == 'All',
              ),
            )),
        SizedBox(
          width: 10,
        ),
        Obx(() => Expanded(
              child: CustomTextButton(
                title: 'Stock',
                onPressed: () {
                  controller.selectedButton.value = 'Stock';
                  controller.fetchInventoryList(filterType: 'Stock');
                },
                textColor: Colors.white,
                selected: controller.selectedButton.value == 'Stock',
              ),
            )),
        SizedBox(
          width: 10,
        ),
        Obx(() => Expanded(
              child: CustomTextButton(
                title: 'Sell',
                onPressed: () {
                  controller.selectedButton.value = 'Sell';
                  controller.fetchInventoryList(filterType: 'Sell');
                },
                textColor: Colors.white,
                fontSize: 18.0,
                selected: controller.selectedButton.value == 'Sell',
              ),
            )),
        SizedBox(
          width: 10,
        )
      ],
    );
  }

  Widget searchBar() {
    return SizedBox(
      height: 50,
      child: CustomTextField(
        hintText: "Search by item code",
        controller: controller.searchController,
        borderSide: const BorderSide(color: AppColors.greyColor, width: 1.0),

        // validator: FieldValidator.validateConfiguration,
      ),
    );
  }

  Widget inventoryListBuilder() {
    return Expanded(
      child: Obx(() {
        if (controller.filteredInventory.isEmpty) {
          return const Center(child: Text('No data available'));
        }
        return ListView.builder(
          itemCount: controller.filteredInventory.length,
          itemBuilder: (context, index) {
            final profile = controller.filteredInventory[index];
            return inventoryItemRow(profile);
          },
        );
      }),
    );
  }

  Widget inventoryItemRow(dynamic profile) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(child: Text(profile.itemCode ?? "")),
      Expanded(child: Text(profile.ModelNumber ?? "")),
      Expanded(child: Text(profile.configuration ?? "")),
      Expanded(child: Text(profile.serialNumber ?? "")),
      Expanded(child: Text(profile.status ?? "")),
      Column(children: [
        IconButton(
          icon: const Icon(Icons.edit, size: 16),
          onPressed: controller.editItem,
        ),
        IconButton(
          icon: const Icon(Icons.delete, size: 16),
          onPressed: controller.deleteItem,
        ),
      ])
    ]);
  }
}
