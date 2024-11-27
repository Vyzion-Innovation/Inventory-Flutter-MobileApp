import 'package:flutter/material.dart';
import 'package:inventoryappflutter/constant/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color textColor;
  final Color backgroundColor;
  final Color pressedColor; // Color when pressed
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final IconData? icon; // Optional icon
  final bool selected; // New parameter for selection state

  const CustomTextButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.textColor = Colors.white,
    this.backgroundColor = AppColors.gradientTwo,
    this.pressedColor = AppColors.gradientOne, // Default pressed color
    this.fontSize = 16.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    this.icon,
    this.selected = false, // Default is not selected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
        backgroundColor: selected ? pressedColor : backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor, size: fontSize + 2),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
