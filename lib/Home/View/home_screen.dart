import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Home/Controller/home_controller.dart';
import 'package:inventoryappflutter/Login/View/login_screen.dart';
import 'package:inventoryappflutter/common/app_common_appbar.dart';
import 'package:inventoryappflutter/common/build_card.dart';

class HomePage extends StatelessWidget {
  final SidePanelController sidePanelController =
      Get.put(SidePanelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Strings.title,
        leading: IconButton(
          icon: Icon(Icons.person), // Button to toggle the side panel
          onPressed: sidePanelController.togglePanel,
        ),
      ),
      body: Row(
        children: [
          // Side Panel
          Obx(() {
            return sidePanelController.isVisible.value
                ? _buildSidePanel() // Display side panel if visible
                : SizedBox.shrink(); // Otherwise, show nothing
          }),
          // Main Content
          Expanded(
            child:  Obx(() {
              return
            GridView.count(
                crossAxisCount: sidePanelController.isVisible.value? 1 : 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 10.0,
                children: [
                  CommonCard(
                    title: Strings.cardTitle,
                    subtitle: 'Subtitle for card 1',
                  ),
                  CommonCard(
                    title: 'Total stock value',
                    subtitle: 'Another subtitle here',
                  ),
                  CommonCard(
                    title: 'Current month inv.',
                    subtitle: 'Another subtitle here',
                  ),
                  CommonCard(
                    title: 'Repair jobs',
                    subtitle: 'Another subtitle here',
                  ),
                  CommonCard(
                    title: 'Current month repair',
                    subtitle: 'Another subtitle here',
                  ),
                ]);
                  }),
          )
        ],
      ),
    );
  }

  // Side Panel Widget
  Widget _buildSidePanel() {
    return Container(
      width: 150, // Fixed width for the side panel
      color: Colors.grey[200], // Background color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Section
          Container(
            color: AppColors.gradientOne,
            padding: EdgeInsets.all(5.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'), // Profile Image
                ),
                SizedBox(height: 10),
                Text(
                  'John Doe', // Dynamic user name
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'johndoe@example.com', // Dynamic email
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Divider(), // Separator line
          // Options
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile Info'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About App'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              sidePanelController.logout();
            },
          ),
        ],
      ),
    );
  }
}
