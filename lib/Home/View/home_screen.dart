import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Constant/app_logo.dart';
import 'package:inventoryappflutter/Home/Controller/dashboard_controller.dart';
import 'package:inventoryappflutter/Home/Controller/drawer_controller.dart';
import 'package:inventoryappflutter/Inventory/view/inventory_details_screen.dart';
import 'package:inventoryappflutter/Login/Controller/login_controller.dart';
import 'package:inventoryappflutter/Model/inventory_model.dart';
import 'package:inventoryappflutter/Profile/View/profile_details.screen.dart';
import 'package:inventoryappflutter/Profile/View/profile_screen.dart';
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
  final RepairController repairController = Get.put(RepairController());

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
              inventoryListBuilder(),
               const SizedBox(height: 20),
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
                  '${dashboardController.repairCount}',
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
        padding: const EdgeInsets.fromLTRB(70, 12, 12, 0),
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

 Widget inventoryListBuilder() {
  return Obx(() {
    final inventory = dashboardController.inventoryList;

    if (inventory.isEmpty) {
      return const Center(
        child: Text(
          'No data available',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Card(
      elevation: 2, // Add elevation for a shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      color: AppColors.secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(5.0), // Padding inside the card
        child: Column(
          children: [
            AppText(
              'Recent Sales List',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              // Use a dynamic height based on the number of items
              height: inventory.length * 105.0, // Example item height is 80.0
              child: ListView.builder(
                shrinkWrap: true, // Allow ListView to size based on its content
                physics: const NeverScrollableScrollPhysics(), // Disable scrolling for the ListView
                itemCount: inventory.length,
                itemBuilder: (context, index) {
                  var profile = inventory[index];
                  return inventoryItemCard(profile, index);
                },
              ),
            )
          ],
        ),
      ),
    );
  });
}

  Widget inventoryItemCard(InventoryModel profile, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CommonCard(
        padding: const EdgeInsets.all(12),
        color: AppColors.lightColor,
        onTap: () {
          Get.to(() => InventoryDetailsScreen(inventory: profile));
        },
        additionalWidgets: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left column for item details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const AppText(
                          'Item Code:  ',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        Expanded(
                          // Wrap with Expanded to prevent overflow
                          child: AppText(
                            profile.itemCode ?? "",
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const AppText(
                          'Sell Amount:  ',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        Expanded(
                          // Wrap with Expanded to prevent overflow
                          child: AppText(
                            profile.sellAmount ?? "",
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Drawer Widget
  Widget _buildDrawer(BuildContext context) {
    final profileData = sidePanelController.profileData;
    return Obx(() => Drawer(
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
                    if (profileData.isNotEmpty) ...[
                      Row(
                        children: [
                          AppText(
                            '${profileData[0].name?[0].toUpperCase()}${profileData[0].name?.substring(1)}',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorWhite,
                          ),
                          const SizedBox(width: 5),
                          AppText(
                            '(${profileData[0].role ?? ''})',
                            fontSize: 15,
                            color: AppColors.colorWhite,
                          ),
                          IconButton(
                            icon: const Icon(Icons.person),
                            onPressed: () {
                              Get.to(() =>
                                  ProfileDetails(profile: profileData.first));
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      AppText(
                        profileData[0].phone ?? '',
                        fontSize: 15,
                        color: AppColors.colorWhite,
                      ),
                    ] else ...[
                      AppText(
                        'No Profile',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorWhite,
                      ),
                    ],
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.person),
                title: AppText(
                  profileData.isEmpty ? 'Add Profile' : "Edit Profile",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                onTap: () async {
                  final result = profileData.isEmpty
                      ? await Get.to(() => ProfileScreen())
                      : await Get.to(
                          () => ProfileScreen(profileData: profileData[0]));

                  if (result == true) {
                    await sidePanelController.fetchProfileData();
                  }
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
        ));
  }
}
