// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:inventoryappflutter/controllers/logoutcontroller.dart';

// class DrawerControllerX extends GetxController {
//   var selectedIndex = 0.obs; // Reactive variable for selected index
  
//  List<String> itemList = ["home", 'Inventory', 'Supplier', 'Profile', 'Logout'];

//   void selectIndex(int index) {
//     selectedIndex.value = index; // Update selected index
//   }

 
// }

// class HomePage extends StatelessWidget {
//   final DrawerControllerX drawerController = Get.put(DrawerControllerX());
//   final LogoutController logoutController = Get.put(LogoutController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Vyzion Innovations')),
        
      
//       drawer: SizedBox(
//         width: 150,
//         child: Drawer(
//           child: ListView(
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.deepPurple,
//                 ),
//                 child: Text(
//                   'Menu',
//                   style: TextStyle(color: Colors.white, fontSize: 24),
//                 ),
//               ),
//               ...List.generate(5, (index) {
//                 return Obx(() => ListTile(
//                       title: Text(drawerController.itemList[index]),
//                       selected: drawerController.selectedIndex.value == index,
//                       onTap: () {
//                         drawerController.selectIndex(index);
//                         Get.back(); // Close the drawer
//                       },
//                     ));
//               }),
//             ],
//           ),
//         ),
//       ),
//       body: Obx(() {
//         return Center(
//           child: Text(
//             'You selected Option ${drawerController.selectedIndex.value + 1}',
//             style: TextStyle(fontSize: 20),
//           ),
//         );
//       }),
//     );
//   }
// }
