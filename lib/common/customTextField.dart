import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? OptionalText;
  final String? rightText;

  final Widget? icon;
  final TextInputType? input;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Widget? suffix;
  final int? MaxLine;
  final int? maxLength;
  final Color? fillColor;
  final BorderSide? borderSide;
  final List<TextInputFormatter>? inputFormatters;
  TextCapitalization? cap;
  FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  bool readOnly;
  double Vertical;
  bool PrimeMember;
  final FocusNode? focusNode;
  bool obscureText;
  final Widget? prefftext;
  bool? enabled;
  CustomTextField({
    super.key,
    this.labelText,
    this.enabled,
    this.icon,
    this.input,
    this.readOnly = false,
    this.obscureText = false,
    this.suffixVisibility = false,
    this.hintText,
    this.controller,
    this.onTap,
    this.MaxLine,
    this.Vertical = 0.0,
    this.suffix,
    this.OptionalText,
    this.PrimeMember = false,
    this.maxLength,
    this.inputFormatters,
    this.validator,
    this.prefixIcon,
    this.fillColor = Colors.white,
    this.borderSide = BorderSide.none,
    this.onChanged,
    this.rightText,
    this.focusNode,
    this.cap,
    this.prefftext,
    this.inputAction,
  });
  bool suffixVisibility;

  @override
  State<CustomTextField> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextField> {
  toggle() {
    setState(() {
      widget.obscureText = !widget.obscureText;
    });
  }

  bool color = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              expands: false,
              textCapitalization: widget.cap ?? TextCapitalization.none,
              enabled: widget.enabled,
              focusNode: widget.focusNode,
              onChanged: widget.onChanged,
              readOnly: widget.readOnly,
              cursorColor: Colors.grey,
              inputFormatters: widget.inputFormatters,
              validator: widget.validator,
              maxLength: widget.maxLength,
              // textAlignVertical: TextAlignVertical.top,
              maxLines: widget.obscureText ? 1 : widget.MaxLine,
              textInputAction: widget.inputAction,
              onTap: widget.onTap,
              controller: widget.controller,
              obscureText: widget.obscureText,
              keyboardType: widget.input,
              obscuringCharacter: '*',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 15,
                  fontFamily: "poppoins"),
              decoration: InputDecoration(
                  prefixIcon: widget.prefftext,
                  counterText: '',
                  contentPadding: const EdgeInsets.only(
                      left: 15, right: 10, top: 8, bottom: 8),
                  suffixIcon: widget.suffixVisibility == false
                      ? widget.suffix
                      : InkWell(
                          onTap: toggle,
                          child: Icon(
                            widget.obscureText
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            size: 20,
                            color: AppColors.primaryColor,
                          ),
                        ),
                  fillColor: widget.fillColor,
                  filled: true,
                  hintText: widget.hintText,
                  labelText: widget.labelText,
                  floatingLabelStyle:
                      const TextStyle(color: AppColors.primaryColor),
                  hintStyle: const TextStyle(
                      color: AppColors.secondaryColor, fontSize: 14),
                  border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: widget.borderSide!),
                  focusedBorder: OutlineInputBorder(
                      borderSide: widget.borderSide!,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: widget.borderSide!,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))
                          )
                          ),
            ),
          ],
        ));
  }
}
