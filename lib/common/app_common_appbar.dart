import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventoryappflutter/common/app_text.dart';

import '../constant/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isCenter;
  final bool? isLeading;
  final Widget? leading;
  final List<Widget>? actions;
  final double? leadingWidth;
  const CustomAppBar(
      {this.title,
      this.isCenter,
      this.isLeading = false,
      this.actions,
      this.leading,
      this.leadingWidth});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      // backgroundColor: AppColors.colorWhite,
      leadingWidth: leading != null ? leadingWidth : null,
      leading: isLeading!
          ? GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.colorBlack,
              ),
            )
          : leading,
      centerTitle: isCenter,
      title: AppText(
        title ?? "",
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColors.colorBlack,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
