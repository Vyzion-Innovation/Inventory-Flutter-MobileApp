import 'package:flutter/material.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';

class CommonDropDownTextField<T> extends StatelessWidget {
  final String labelText;
  final String hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;
  final Color fillColor;
final BorderSide? borderSide;

  const CommonDropDownTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.value,
    required this.items,
    this.onChanged,
    this.validator,
    this.fillColor = Colors.white,
    this.borderSide = BorderSide.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        filled: true,
        fillColor: fillColor,
        
        border:  OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: borderSide!),
                  focusedBorder: OutlineInputBorder(
                      borderSide: borderSide!,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: borderSide!,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))
                          )
      ),
       style: const TextStyle(
                  color: AppColors.colorBlack,
                  fontSize: 16,
                  fontFamily: "poppoins"),
      value: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
