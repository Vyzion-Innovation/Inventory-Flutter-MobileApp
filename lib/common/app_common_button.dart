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

  final double? fontSize;
  const CustomButton(
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
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: color == AppColors.primaryColor
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
            fontSize: 15,
            color: AppColors.colorWhite,
            fontWeight: FontWeight.normal,
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
