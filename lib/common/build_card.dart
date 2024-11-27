import 'package:flutter/material.dart';

class CommonCard extends StatelessWidget {
  final String title;
  final Widget subtitle;
  final List<Widget> additionalWidgets;

  const CommonCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.additionalWidgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          subtitle,
          const SizedBox(height: 16),
          ...additionalWidgets,
        ],
      ),
    );
  }
}
