import 'package:get/get.dart';
import 'package:inventoryappflutter/Login/View/login_screen.dart';

class SidePanelController extends GetxController {
  var isVisible = false.obs; // Tracks visibility of the side panel

  void togglePanel() {
    isVisible.value = !isVisible.value; // Toggles the panel visibility
  }
   void logout() {
    Get.offAll(LoginScreenPage());
  }
}
