import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/BottomNavBar/View/navbar_screen.dart';
import 'package:inventoryappflutter/Login/View/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App with Drawer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreenPage()),
       
      ],
    );
  }
}


