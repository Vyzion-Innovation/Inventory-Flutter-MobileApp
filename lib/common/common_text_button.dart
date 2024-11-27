import 'package:flutter/material.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/common/app_text.dart';
class CustomTextButton extends StatelessWidget {
 final Function()? onTap;
  final String? title;
  final double? width;
  final Color? color;
  final Color? textColor;
  final FontWeight? textWeight;

  final double? fontSize;
  const CustomTextButton(
      {super.key,
      this.onTap,
      this.title,
      this.width,
      this.fontSize,
      this.color,
      this.textColor,
      this.textWeight});
            
              @override
              Widget build(BuildContext context) {
                // TODO: implement build
                return 
                  TextButton(
              child: AppText(
            title ?? "",
            fontSize: 12,
            color: AppColors.gradientOne,
            fontWeight: FontWeight.normal,
          ),
              onPressed: onTap 
            );
              }
}