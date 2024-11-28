import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant/app_colors.dart';
import 'app_text.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String? title;
  final double? width;
  final Color? color;
  final Color? textColor;
  final FontWeight? textWeight;
  final bool selected; 
  final double? fontSize;

  const CustomButton({
    Key? key,
    this.onTap,
    this.title,
    this.width,
    this.fontSize,
    this.color,
    this.textColor,
    this.selected = false,
    this.textWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: width ?? double.infinity, // Use the provided width or default to full width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: selected 
              ? const LinearGradient(colors: <Color>[
                  AppColors.gradientOne,
                  AppColors.gradientTwo,
                ])
              : LinearGradient(colors: <Color>[
                  color ?? AppColors.gradientOne,
                  color ?? AppColors.gradientTwo,
                ]),
        ),
        child: Center(
          child: AppText(
            title ?? "",
            fontSize: fontSize ?? 15, // Use provided fontSize or default to 15
            color: textColor ?? AppColors.colorWhite, // Use provided textColor or default to white
            fontWeight: textWeight ?? FontWeight.normal, // Use provided textWeight or default to normal
          ),
        ),
      ),
    );
  }
}

class AlertPopUp extends StatelessWidget {
  final Function()? onTap;
  final String? title;
  const AlertPopUp({
    super.key,
    this.onTap,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            content: AppText(
              title ?? "",
              fontSize: 18,
            ),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: AppText(
                  "no",
                  fontSize: 15,
                ),
              ),
              CupertinoDialogAction(
                isDestructiveAction: false,
                onPressed: onTap,

                // () async {
                //   Navigator.pop(context);
                //   model.logout();
                // },
                child: AppText(
                  "Yes",
                  fontSize: 15,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
