import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/BottomNavBar/Controller/navbar_controller.dart';
import 'package:inventoryappflutter/Home/View/home_screen.dart';

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
              label: 'Home', // Label for Home tab
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory), // Inventory Icon
              label: 'Inventory', // Label for Inventory tab
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build), // Repairs Icon
              label: 'Repairs', // Label for Repairs tab
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people), // Customer Icon
              label: 'Customer', // Label for Customer tab
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store), // Supplier Icon
              label: 'Supplier', // Label for Supplier tab
            ),
          ],
        );
      }),
    );
  }

  // Function to return content for each selected tab
  Widget _buildTabContent(String item) {
    switch (item) {
      case 'home':
        return Center(child: HomePage());
      case 'Inventory':
        return const Center(child: Text('Inventory Screen'));
      case 'Repairs':
        return const Center(child: Text('Repairs Screen'));
      case 'Customer':
        return const Center(child: Text('Customer Screen'));
      case 'Supplier':
        return const Center(child: Text('Supplier Screen'));
      default:
        return const Center(child: Text('Home Screen'));
    }
  }
}
