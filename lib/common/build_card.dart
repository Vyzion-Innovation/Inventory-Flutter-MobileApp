import 'package:flutter/material.dart';

class CommonCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final List<Widget>? additionalWidgets;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap; // Callback for handling taps

  const CommonCard({
    Key? key,
    this.title,
    this.subtitle,
    this.padding,
    this.additionalWidgets,
    this.onTap, // Optional parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Handle tap if onTap is provided
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
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
              Text(
                title!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8), // Space after title
            ],
            if (subtitle != null && subtitle!.isNotEmpty) ...[
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16), // Space after subtitle
            ],
            if (additionalWidgets != null && additionalWidgets!.isNotEmpty)
              ...additionalWidgets!,
          ],
        ),
      ),
    );
  }
}
