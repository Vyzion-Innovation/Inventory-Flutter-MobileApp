import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child; // Accepts a child widget

  // Constructor to accept width, height, and child parameters
  const CustomSizedBox({
    Key? key,
    this.width = 0.0,
    this.height = 0.0,
    this.child, // The child widget is optional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: child, // The child is placed inside the SizedBox
    );
  }
}
