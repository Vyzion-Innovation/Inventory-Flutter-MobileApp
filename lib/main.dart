import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Customer/View/add_customer_screen.dart';
import 'package:inventoryappflutter/Add_Inventory/View/add_inventory.dart';
import 'package:inventoryappflutter/Add_Repair/View/repair_screen.dart';
import 'package:inventoryappflutter/Add_Supplier/View/add_supplier_screen.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/route_string_class.dart';
import 'package:inventoryappflutter/Customer/View/customer_screen.dart';
import 'package:inventoryappflutter/Home/View/home_screen.dart';
import 'package:inventoryappflutter/Inventory/view/inventory_screen.dart';
import 'package:inventoryappflutter/Profile/View/profile_screen.dart';
import 'package:inventoryappflutter/Repair/View/repair_screen.dart';
import 'package:inventoryappflutter/Supplier/View/supllier_screen.dart';
import 'package:inventoryappflutter/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inventoryappflutter/Login/View/login_screen.dart';
import 'package:inventoryappflutter/BottomNavBar/View/navbar_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Use the options from firebase_options.dart
  );
     final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool(Strings.ifLogin) ?? false;
  final initialRoute = isLoggedIn ?  RouteString.navBar :  RouteString.login;

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter App with Drawer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: RouteString.login, page: () => LoginScreenPage()),
        GetPage(name: RouteString.navBar, page: () => NavBarScreen()),
         GetPage(name: RouteString.home, page: () => HomePage()),
        GetPage(name: RouteString.inventory, page: () => InventoriesScreen()),
         GetPage(name: RouteString.addInventory, page: () => InventoryFormScreen()),
        GetPage(name: RouteString.repair, page: () => RepairScreen()),
         GetPage(name: RouteString.addRepair, page: () => RepairFormScreen()),
        GetPage(name: RouteString.customer, page: () => CustomerScreen()),
         GetPage(name: RouteString.addCustomer, page: () => AddCustomerScreen()),
         GetPage(name: RouteString.addSupplier, page: () => AddSupplierScreen()),
         GetPage(name: RouteString.supplier, page: () => SupllierScreen()),
         GetPage(name: RouteString.profile, page: () => ProfileScreen()),

      ],
    );
  }
}
