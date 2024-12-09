import 'package:get/get.dart';
import 'package:inventoryappflutter/Profile/View/profile_screen.dart';

class SidePanelController extends GetxController {
  var isVisible = false.obs; // Tracks visibility of the side panel

  void togglePanel() {
    isVisible.value = !isVisible.value; // Toggles the panel visibility
  }
   void profileScreenRoute() {
    Get.to(() => ProfileScreen());
  }
}
