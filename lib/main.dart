import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/route_string_class.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inventoryappflutter/Login/View/login_screen.dart';
import 'package:inventoryappflutter/BottomNavBar/View/navbar_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Determine the initial route based on login state
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
      ],
    );
  }
}
