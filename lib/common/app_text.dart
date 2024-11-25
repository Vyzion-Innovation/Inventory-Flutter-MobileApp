import 'package:flutter/material.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';

class AppText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final double? letterSpacing;
  final double? height;
  final TextDecoration textDecoration;
  final TextAlign textAlign;
  final int maxLines;
  final FontStyle fontStyle;

  const AppText(
    this.text, {
    Key? key,
    this.fontSize = 10,
    this.color,
    this.fontWeight = FontWeight.w300,
    this.letterSpacing,
    this.textDecoration = TextDecoration.none,
    this.textAlign = TextAlign.start,
    this.height,
    this.maxLines = 100,
    this.fontStyle = FontStyle.normal,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: fontFamily, // Optional font family
        height: height, // Line height
        color: color ?? AppColors.darkColor, // Default to darkColor if not provided
        fontSize: fontSize, // Font size
        fontWeight: fontWeight, // Font weight
        fontStyle: fontStyle, // Italic or normal
        letterSpacing: letterSpacing, // Character spacing
        decoration: textDecoration, // Underline, overline, etc.
      ),
    );
  }
}
