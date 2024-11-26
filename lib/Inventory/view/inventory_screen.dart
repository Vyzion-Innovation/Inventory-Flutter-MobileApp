

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inventoryappflutter/AddInventory/View/add_inventory.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Inventory/Controller/inventory_controller.dart';
import 'package:inventoryappflutter/common/app_common_appbar.dart';
import 'package:inventoryappflutter/common/app_common_button.dart';

class InventoriesScreen extends StatelessWidget {
  final InventoriesController controller = Get.put(InventoriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: CustomAppBar(
        title: Strings.inventory,
        actions: [
          IconButton( onPressed: () { 
          controller.addItem();
           },  icon: const Icon(
              Icons.add,
            ),)
        ]
       
      ),
      // body: Padding(
      //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
      //   child: inventoryListView(),
      // ),
    );
  }

  Widget inventoryListView() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              // headerRow(),
              // const Divider(),
              filterAndSearchSection(),
              const Divider(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Text('Item code',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text('Model no.',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text('Configuration',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text('Serial no.',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text('Status',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text('Actions',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
              const Divider(),
              inventoryListBuilder(),
            ],
          ),
        ),
      ],
    );
  }

  Widget filterAndSearchSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        filterButtons(),
        searchBar(),
      ],
    );
  }

  Widget filterButtons() {
    return Row(
      children: [
        Obx(() => CustomButton(
              title: 'All',
              onTap: () {
                controller.selectedButton.value = 'All';
                controller.fetchInventoryList(filterType: 'All');
              },
              textColor: Colors.white,
             
              // selected: controller.selectedButton.value == 'All',
            )),
        const SizedBox(width: 10),
        Obx(() => CustomButton(
              title: 'Stock',
              onTap: () {
                controller.selectedButton.value = 'Stock';
                controller.fetchInventoryList(filterType: 'Stock');
              },
              textColor: Colors.white,
            
              // selected: controller.selectedButton.value == 'Stock',
            )),
        const SizedBox(width: 10),
        Obx(() => CustomButton(
              title: 'Sell',
              onTap: () {
                controller.selectedButton.value = 'Sell';
                controller.fetchInventoryList(filterType: 'Sell');
              },
              textColor: Colors.white,
             
              fontSize: 18.0,
             
              // selected: controller.selectedButton.value == 'Sell',
            )),
      ],
    );
  }

  Widget searchBar() {
    return SizedBox(
      width: 130,
      child: TextField(
        controller: controller.searchController,
        decoration: InputDecoration(
          labelText: 'Search by item code',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget headerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Inventories List',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ElevatedButton(
          onPressed: controller.addItem,
          child: const Text('Add'),
        ),
      ],
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
