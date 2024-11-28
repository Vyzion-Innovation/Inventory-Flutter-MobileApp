import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';

// ignore: must_be_immutable
class CommonDropDownTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final Function(String?)? onChanged;
  final FormFieldValidator<String>? validator;
  final List<DropdownMenuItem<String>>? items;
  final String? value; // Added for selected value
  final Color? fillColor;
  final BorderSide? borderSide;
  final double? fontsize;
  final AlignmentGeometry? alignment;

  final bool readOnly;
  final FocusNode? focusNode;
  final double leftPadding;
  final double rightPadding;

  CommonDropDownTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.onChanged,
    this.validator,
    this.items,
    this.value,
    this.fillColor = Colors.white,
    this.borderSide =
        const BorderSide(color: AppColors.primaryColor, width: 1.0),
    this.fontsize,
    this.alignment,
    this.readOnly = false,
    this.focusNode,
    this.leftPadding = 15,
    this.rightPadding = 10,
  });

  @override
  State<CommonDropDownTextField> createState() =>
      _CommonDropDownTextFieldState();
}

class _CommonDropDownTextFieldState extends State<CommonDropDownTextField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      alignment: widget.alignment ?? AlignmentDirectional.centerStart,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          left: widget.leftPadding,
          right: widget.rightPadding,
        ),
        fillColor: widget.fillColor,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: widget.borderSide!),
        focusedBorder: OutlineInputBorder(
            borderSide: widget.borderSide!,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(
            borderSide: widget.borderSide!,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        floatingLabelStyle: const TextStyle(color: AppColors.primaryColor),
        hintStyle: TextStyle(
          color: AppColors.greyColor,
          fontSize: widget.fontsize,
          fontWeight: FontWeight.w400,
        ),
        hintText: widget.hintText,
        labelText: widget.labelText,
      ),
      items: widget.items,
      onChanged: widget.onChanged,
      value: widget.value,
      validator: widget.validator,
    );
  }
}
