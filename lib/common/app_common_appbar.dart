import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_colors.dart';
import '../common/app_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool isCenter;
  final bool isLeading;
  final Widget? leading;
  final List<Widget>? actions;
  final double? leadingWidth;
  final VoidCallback? onTapLeading; // Add onTapLeading callback

  const CustomAppBar({
    this.title,
    this.isCenter = false,
    this.isLeading = false,
    this.actions,
    this.leading,
    this.leadingWidth,
    this.onTapLeading, // Include onTapLeading in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.deselectSegment,
      leadingWidth: leading != null ? leadingWidth : null,
      leading: isLeading
          ? GestureDetector(
              onTap: onTapLeading ?? () => Get.back(), // Use the provided callback or default to back action
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.colorBlack,
              ),
            )
          : leading,
      centerTitle: isCenter,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
