import 'package:flutter/material.dart';

class CommonCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color? cardColor;

  const CommonCard({
    Key? key,
    required this.title, // The card's main title
    this.subtitle, // Optional subtitle
    this.leadingIcon, // Optional leading icon
    this.trailing, // Optional trailing widget (e.g., Icon, Button)
    this.onTap, // Optional onTap callback
    this.padding = const EdgeInsets.all(16.0), // Default padding
    this.cardColor, // Optional custom background color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor ?? Colors.white, // Default to white if no color provided
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      elevation: 4, // Elevation for shadow effect
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap, // Execute onTap callback when card is tapped
        child: Padding(
          padding: padding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leadingIcon != null) ...[
                Icon(
                  leadingIcon,
                  size: 32,
                  color: Colors.blue, // Customize icon color
                ),
                const SizedBox(width: 12), // Add space between icon and text
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4), // Space between title and subtitle
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey, // Customize subtitle color
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
