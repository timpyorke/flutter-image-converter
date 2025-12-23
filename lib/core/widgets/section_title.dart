import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final List<Widget>? body;

  const SectionTitle({super.key, required this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          ...?body,
        ],
      ),
    );
  }
}
