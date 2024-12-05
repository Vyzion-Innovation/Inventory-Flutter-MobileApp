import 'package:flutter/material.dart';

class CommonDropDownTextField<T> extends StatelessWidget {
  final String labelText;
  final String hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;
  final Color fillColor;
  final BorderSide borderSide;

  const CommonDropDownTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.value,
    required this.items,
    this.onChanged,
    this.validator,
    this.fillColor = Colors.white,
    this.borderSide = const BorderSide(color: Colors.black),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: borderSide,
        ),
      ),
      value: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
