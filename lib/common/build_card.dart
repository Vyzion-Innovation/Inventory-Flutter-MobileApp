import 'package:flutter/material.dart';
import 'package:inventoryappflutter/common/app_text.dart';

class CommonCard extends StatelessWidget {
  final String? title;
   final double? width;
  final String? subtitle;
  final List<Widget>? additionalWidgets;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final VoidCallback? onTap; // Callback for handling taps

  const CommonCard({
    Key? key,
    this.title,
    this.color = Colors.white,
    this.subtitle,
    this.padding,
    this.width,
    this.additionalWidgets,
    this.onTap, // Optional parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
       borderRadius: BorderRadius.circular(12),
      child: Material(
        child: InkWell(
          onTap: onTap, // Handle tap if onTap is provided
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color:color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: padding ?? const EdgeInsets.all(16), // Default padding if not provided
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null && title!.isNotEmpty) ...[
                  AppText(
                    title!,
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                   
                  ),
                  const SizedBox(height: 8), // Space after title
                ],
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  AppText(
                    subtitle!,
                   fontSize: 16,
                  ),
                  const SizedBox(height: 16), // Space after subtitle
                ],
                if (additionalWidgets != null && additionalWidgets!.isNotEmpty)
                  ...additionalWidgets!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
