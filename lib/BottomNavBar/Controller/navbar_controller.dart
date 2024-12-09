import 'package:get/get.dart';

class DrawerControllerX extends GetxController {
  var selectedIndex = 0.obs; // Reactive variable for selected index
  
 

  void selectIndex(int index) {
    selectedIndex.value = index; // Update selected index
  }

 
}