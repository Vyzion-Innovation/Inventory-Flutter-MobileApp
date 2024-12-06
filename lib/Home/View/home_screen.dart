import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Constant/app_logo.dart';
import 'package:inventoryappflutter/Home/Controller/dashboard_controller.dart';
import 'package:inventoryappflutter/Home/Controller/drawer_controller.dart';
import 'package:inventoryappflutter/Login/Controller/login_controller.dart';
import 'package:inventoryappflutter/Repair/Controller/repair%20controller.dart';
import 'package:inventoryappflutter/common/app_common_appbar.dart';
import 'package:inventoryappflutter/common/app_common_button.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/build_card.dart';
import 'package:inventoryappflutter/common/common_text_button.dart';

class HomePage extends StatelessWidget {
  final SidePanelController sidePanelController =
      Get.put(SidePanelController());
  final LoginController loginController = Get.put(LoginController());
   final DashboardController dashboardController =
      Get.put(DashboardController());
      final RepairController repairController =
      Get.put(RepairController());
  

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppText(
          Strings.home,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawer: SizedBox(
        width: 250,
        child: _buildDrawer(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildDashboardGrid(),
              const SizedBox(height: 20),
              _buildQuickActions(),
               const SizedBox(height: 20),
              _recentSalesList()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15.0,
      mainAxisSpacing: 15.0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        CommonCard(
          padding: const EdgeInsets.all(12),
          title: 'Total Stock Count',
          additionalWidgets: [
            Obx(
              () => Center(
                child: AppText(
                  '${dashboardController.count}',
                  fontSize: 15,
                  color: AppColors.gradientOne,
                ),
              ),
            )
          ],
        ),
        CommonCard(
          padding: const EdgeInsets.all(12),
          title: 'Total Stock Value',
          additionalWidgets: [
            Obx(
              () => Center(
                child: AppText(
                  '${dashboardController.totalPurchaseAmount}',
                  fontSize: 15,
                  color: AppColors.gradientOne,
                ),
              ),
            )
          ],
        ),
        CommonCard(
          padding: const EdgeInsets.all(12),
          title: 'Current Month Sale',
          additionalWidgets: [
            Obx(
              () => Center(
                child: AppText(
                  '${dashboardController.totalSelleAmount}',
                  fontSize: 15,
                  color: AppColors.gradientOne,
                ),
              ),
            )
          ],
        ),
        CommonCard(
          padding: const EdgeInsets.all(12),
          title: 'Repair Jobs',
          additionalWidgets: [
            Obx(
              () => Center(
                child: AppText(
                  '${repairController.count}',
                  fontSize: 15,
                  color: AppColors.gradientOne,
                ),
              ),
            )
          ],
        ),
         CommonCard(
          padding: EdgeInsets.all(12),
          title: 'Current Month Repair Job',
          additionalWidgets: [
           Obx(
              () => Center(
              child: AppText(
                  '${dashboardController.currentMonthRepairAmount}',
                  fontSize: 15,
                  color: AppColors.gradientOne,
                ),
            ),
           )
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Center(
      child: CommonCard(
        width: 400,
        padding: const EdgeInsets.fromLTRB(70,12,12,0),
        title: 'Quick Actions',
        additionalWidgets: [
          CustomTextButton(
            onPressed: () {
              dashboardController.aboutScreenRoute('inventory');
            },
            title: 'Add Inventory',
          ),
          CustomTextButton(
            onPressed: () {
              dashboardController.aboutScreenRoute('customer');
            },
            title: 'Add Customers',
          ),
          CustomTextButton(
            onPressed: () {
              dashboardController.aboutScreenRoute('supplier');
            },
            title: 'Add Suppliers',
          ),
          CustomTextButton(
            onPressed: () {
              dashboardController.aboutScreenRoute('repair');
            },
            title: 'Add Repairs',
          ),
        ],
      ),
    );
  }
   Widget _recentSalesList() {
    return Center(
      child: CommonCard(
        width: 400,
         padding: const EdgeInsets.fromLTRB(70,12,12,0),
        title: 'recent Sales List',
        additionalWidgets: [
         
        ],
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
                ClipOval(
                  child: Image.asset(
                    AppLogo.companyLogo,
                    height: MediaQuery.of(context).size.height / 8,
                    fit: BoxFit.scaleDown,
                    matchTextDirection: true,
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
            onTap: () {
              sidePanelController.profileScreenRoute();
            },
          ),
          ListTile(
            leading: const Icon(Icons.details_rounded),
            title: const AppText(
              'About App',
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            onTap: () {
              sidePanelController.aboutScreenRoute();
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const AppText(
              'Logout',
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) => AlertPopUp(
                  title: 'Do you really want to logout?',
                  onTap: () {
                    Navigator.pop(context); // Close the dialog
                    loginController.logout(); // Perform logout
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
