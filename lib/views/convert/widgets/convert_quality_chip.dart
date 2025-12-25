import 'package:flutter/material.dart';

class ConvertQualityChip extends StatelessWidget {
  const ConvertQualityChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.quality,
    required this.updateQuality,
  });

  final String label;
  final bool isSelected;
  final int quality;
  final Function(int) updateQuality;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        updateQuality(quality);
      },
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedColor: Theme.of(
        context,
      ).colorScheme.primary.withValues(alpha: 0.2),
      checkmarkColor: Theme.of(context).colorScheme.primary,
      labelStyle: TextStyle(
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide(
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
