import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/BottomNavBar/Controller/navbar_controller.dart';
import 'package:inventoryappflutter/Customer/Controller/customer_controller.dart';
import 'package:inventoryappflutter/Customer/View/customer_screen.dart';
import 'package:inventoryappflutter/Home/Controller/dashboard_controller.dart';
import 'package:inventoryappflutter/Home/View/home_screen.dart';
import 'package:inventoryappflutter/Inventory/Controller/inventory_controller.dart';
import 'package:inventoryappflutter/Inventory/view/inventory_screen.dart';
import 'package:inventoryappflutter/Repair/Controller/repair%20controller.dart';
import 'package:inventoryappflutter/Repair/View/repair_screen.dart';
import 'package:inventoryappflutter/Supplier/Controller/supplier_controller.dart';
import 'package:inventoryappflutter/Supplier/View/supllier_screen.dart';

class NavBarScreen extends StatelessWidget {
  final NavBarControllerX navBarController = Get.put(NavBarControllerX());

  final List<Widget> screens = [
    HomePage(),
    InventoriesScreen(),
    RepairScreen(),
    CustomerScreen(),
    SupllierScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Rebuild the screen each time the tab changes
        return screens[navBarController.selectedIndex.value];
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: navBarController.selectedIndex.value,
          onTap: (index) {
            navBarController.selectIndex(index); // Update the selected index

            // Refresh the relevant screen
            switch (index) {
              case 0:
                Get.find<DashboardController>().fetchStockCountAndSum();
                Get.find<DashboardController>().fetchSellCountAndSum();
                 Get.find<DashboardController>().fetchRepairList();
                Get.find<DashboardController>().fetchRepairListCount();
                break;
              case 1:
                Get.find<InventoriesController>().fetchInventories();
                break;
              case 2:
                Get.find<RepairController>().fetchRepairList();
             
                break;
              case 3:
                Get.find<CustomerController>().fetchCustomers();
                break;
              case 4:
                Get.find<SupplierController>().fetchSuppliers();
                break;
            }
          },
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.gradientTwo,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: Strings.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory),
              label: Strings.inventory,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build),
              label: Strings.repair,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: Strings.customer,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: Strings.supplier,
            ),
          ],
        );
      }),
    );
  }
}
