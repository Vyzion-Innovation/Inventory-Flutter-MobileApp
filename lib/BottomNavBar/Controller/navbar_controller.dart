import 'package:get/get.dart';

class NavBarControllerX extends GetxController {
  // Tracks the selected index
  var selectedIndex = 0.obs;

  // Function to update the selected index
  void selectIndex(int index) {
    selectedIndex.value = index;
  }
}
