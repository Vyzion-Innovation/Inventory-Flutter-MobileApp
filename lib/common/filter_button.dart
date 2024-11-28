import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Assuming you're using GetX for state management

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;

  const FilterButton({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedColor = Colors.blue, // Default selected color
    this.unselectedColor = Colors.black, // Default unselected color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? selectedColor : unselectedColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Underline
          Container(
            height: 2,
            color: isSelected ? selectedColor : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
