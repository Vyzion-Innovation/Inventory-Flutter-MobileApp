import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Constant/app_logo.dart';
import 'package:inventoryappflutter/Home/Controller/home_controller.dart';
import 'package:inventoryappflutter/Login/Controller/login_controller.dart';
import 'package:inventoryappflutter/Login/View/login_screen.dart';
import 'package:inventoryappflutter/common/app_common_appbar.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/build_card.dart';
import 'package:inventoryappflutter/common/common_text_button.dart';

class HomePage extends StatelessWidget {
  final SidePanelController sidePanelController = Get.put(SidePanelController());
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppText( Strings.home , fontSize: 20, fontWeight: FontWeight.bold,),
      ),
      drawer: SizedBox(
        width: 250,
        child: _buildDrawer(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Main Content
              Expanded(
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  children: const [
                     CommonCard(
                       padding: EdgeInsets.all(12), 
                      title: 'Total Stock Count',
                      // subtitle:'This is an optional subtitle',
                      additionalWidgets: [
                        Center(child: AppText('0',fontSize: 15, color: AppColors.gradientOne,)),
                     
                      ],
                    ),
                    CommonCard(
                     padding: EdgeInsets.all(12), 
                      title: 'Total Stock Value',
                      // subtitle: 'This is an optional subtitle',
                      additionalWidgets: [
                        Center(child: AppText('Rs 0', fontSize: 15,color:  AppColors.gradientOne)),
                       
                      ],
                    ),
                    CommonCard(
                       padding: EdgeInsets.all(12), 
                      title: 'Card Title',
                      subtitle: 'This is an optional subtitle',
                      additionalWidgets: [
                        Text('This is some additional text'),
                       
                      ],
                    ),
                     CommonCard(
                       padding: EdgeInsets.all(12), 
                      title: 'Card Title',
                      subtitle: 'This is an optional subtitle',
                      additionalWidgets: [
                        Text('This is some additional text'),
                        Text('This is some additional text'),
                        Text('This is some additional text'),
                        Text('This is some additional text'),
                        Text('This is some additional text'),Text('This is some additional text'),
                        Text('This is some additional text'),
                     
                      ],
                    ),
                     CommonCard(
                       padding: EdgeInsets.all(12), 
                      title: 'Card Title',
                      subtitle: 'This is an optional subtitle',
                      additionalWidgets: [
                        Text('This is some additional text'),
                       
                      ],
                    ),
          
                  ]
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Drawer Widget
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 250,
            color: AppColors.gradientOne,
            padding: const EdgeInsets.fromLTRB(40.0, 50, 0, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Image.asset(
                    AppLogo.companyLogo,
                    height: MediaQuery.of(context).size.height / 4,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const SizedBox(height: 10),
                const AppText(
                  'Pawan Ginti',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorWhite,
                ),
                const SizedBox(height: 5),
                const AppText(
                  'P@p.com',
                  fontSize: 15,
                  color: AppColors.colorWhite,
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const AppText(
              'Profile',
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.details_rounded),
            title: const AppText(
              'About App',
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const AppText(
              'Logout',
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            onTap: () {
              loginController.logout();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
