import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inventoryappflutter/AddInventory/View/add_inventory.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Extension/form_validator.dart';
import 'package:inventoryappflutter/Inventory/Controller/inventory_controller.dart';
import 'package:inventoryappflutter/Repair/Controller/repair%20controller.dart';
import 'package:inventoryappflutter/common/app_common_appbar.dart';
import 'package:inventoryappflutter/common/app_common_button.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/common_text_button.dart';
import 'package:inventoryappflutter/common/customTextField.dart';

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
          inventoryListView(), // Column Headers
          Divider(),
          inventoryItemRow(), // Data Rows
        ],
      ),
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
  Widget inventoryListView() {
    return Container(
      
      child: Table(
        columnWidths: {
          0: FixedColumnWidth(60), // Fixed width for Item code column
          1: FixedColumnWidth(60), // Fixed width for Model no. column
          2: FixedColumnWidth(100), // Fixed width for Configuration column
          3: FixedColumnWidth(55), // Fixed width for Serial no. column
          4: FixedColumnWidth(55), // Fixed width for Status column
          5: FixedColumnWidth(60),  // Fixed width for Actions column
        },
        border: TableBorder.all(),
        children: [
          TableRow(
            decoration: BoxDecoration(color: Colors.grey.shade300),
            children: const [
              TableCell(child: Padding(padding: EdgeInsets.all(8), child: AppText('Item code', fontWeight: FontWeight.bold, fontSize: 11))),
              TableCell(child: Padding(padding: EdgeInsets.all(8), child: AppText('Model no.', fontWeight: FontWeight.bold, fontSize: 11))),
              TableCell(child: Padding(padding: EdgeInsets.all(8), child: AppText('Configuration', fontWeight: FontWeight.bold, fontSize: 11))),
              TableCell(child: Padding(padding: EdgeInsets.all(8), child: AppText('Serial no.', fontWeight: FontWeight.bold, fontSize: 11))),
              TableCell(child: Padding(padding: EdgeInsets.all(8), child: AppText('Status', fontWeight: FontWeight.bold, fontSize: 11))),
              TableCell(child: Padding(padding: EdgeInsets.all(8), child: AppText('Action', fontWeight: FontWeight.bold, fontSize: 11))),
            ],
          ),
        ],
      ),
    );
  }

  Widget inventoryListBuilder() {
    return Obx(() {
      if (controller.filteredInventory.isEmpty) {
        return const Center(child: Text('No data available'));
      }
      return ListView.builder(
        itemCount: controller.filteredInventory.length,
        itemBuilder: (context, index) {
          final profile = controller.filteredInventory[index];
          return inventoryItemRow();
        },
      );
    });
  }

  Widget inventoryItemRow() {
    return Table(
      
      columnWidths: {
       0: FixedColumnWidth(60), // Fixed width for Item code column
          1: FixedColumnWidth(60), // Fixed width for Model no. column
          2: FixedColumnWidth(100), // Fixed width for Configuration column
          3: FixedColumnWidth(55), // Fixed width for Serial no. column
          4: FixedColumnWidth(55), // Fixed width for Status column
          5: FixedColumnWidth(60), 
      },
        border: TableBorder.all(),
      children: [
        TableRow(
           decoration: BoxDecoration(color: Colors.white30),
          children: [
            TableCell(child: Text("fghfghfgh")),
            TableCell(child: Text( "dgfdgdfg")),
            TableCell(child: Text("dfgdfgdfg")),
            TableCell(child: Text( "dfgdfgfg")),
            TableCell(child: Text( "gfdfgdfg")),
            TableCell(
              child: Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: IconButton(
                        icon: const Icon(Icons.edit, size: 16),
                        onPressed: controller.editItem,
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: const Icon(Icons.delete, size: 16),
                        onPressed: controller.deleteItem,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
