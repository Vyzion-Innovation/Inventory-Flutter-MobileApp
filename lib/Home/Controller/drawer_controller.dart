import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Model/profile_model.dart';
import 'package:inventoryappflutter/Profile/View/profile_screen.dart';
import 'package:inventoryappflutter/about_screen.dart';

class SidePanelController extends GetxController {
  var isVisible = false.obs; // Tracks visibility of the side panel
var profileData = <ProfileModel>[].obs;
  // 
   void profileScreenRoute() {
    Get.to(() => ProfileScreen());
  }
  void aboutScreenRoute() {
    Get.to(() => AboutScreen());
  }
  
   @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  @override
  void onClose() {
   
    super.onClose();
  }
  Future<void> fetchProfileData() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('myprofile').get();
      List<ProfileModel> profile = snapshot.docs.map((doc) {
        return 
         ProfileModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      profileData.assignAll(profile);
   
    
       
    } catch (e) {
      print("Error fetching suppliers: $e");
    }
  }
}
