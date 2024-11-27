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
      // body: Column(
      //   children: [
      //     filterButtons(),
         
      //     Expanded(child: inventoryListBuilder()),
      //   ],
      // ),
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
