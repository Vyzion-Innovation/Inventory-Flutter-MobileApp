import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/BottomNavBar/Controller/navbar_controller.dart';
import 'package:inventoryappflutter/Home/View/home_screen.dart';
import 'package:inventoryappflutter/Inventory/view/inventory_screen.dart';
import 'package:inventoryappflutter/Repair/View/repair_screen.dart';
import 'package:inventoryappflutter/Supplier/View/supllier_screen.dart';

class NavBarScreen extends StatelessWidget {
  // Get the controller instance
  final DrawerControllerX drawerController = Get.put(DrawerControllerX());

  final List<String> itemList = ["home", 'Inventory', 'Repairs', 'Customer', 'Supplier'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Listen to the selectedIndex change
        return _buildTabContent(itemList[drawerController.selectedIndex.value]);
      }),
      bottomNavigationBar: Obx(() {
        // Make the bottom nav reactive
        return BottomNavigationBar(
          currentIndex: drawerController.selectedIndex.value, // Track selected index
          onTap: (index) {
            drawerController.selectIndex(index); // Update selected index
          },
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.gradientTwo,
          
          type: BottomNavigationBarType.fixed, // Ensures consistent spacing
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home), // Home Icon
              label: Strings.home, // Label for Home tab
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory), // Inventory Icon
              label: Strings.inventory, // Label for Inventory tab
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build), // Repairs Icon
              label: Strings.repair, // Label for Repairs tab
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people), // Customer Icon
              label: Strings.customer, // Label for Customer tab
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store), // Supplier Icon
              label: Strings.supplier, // Label for Supplier tab
            ),
          ],
        );
      }),
    );
  }

  // Function to return content for each selected tab
  Widget _buildTabContent(String item) {
    switch (item) {
      case Strings.home:
        return Center(child: HomePage());
      case Strings.inventory:
        return  Center(child: InventoriesScreen());
      case Strings.repair:
        return  Center(child: RepairScreen());
      case Strings.customer:
        return  Center(child: SupllierScreen());
      case Strings.supplier:
        return  Center(child: SupllierScreen());
      default:
        return Center(child: HomePage());
    }
  }
}
