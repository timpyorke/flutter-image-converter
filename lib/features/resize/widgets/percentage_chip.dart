import 'package:flutter/material.dart';
import 'package:flutter_image_converters/data/image_data.dart';

class PercentageChip extends StatelessWidget {
  const PercentageChip({
    super.key,
    required this.percentage,
    this.sourceImage,
    required this.updateSize,
    required this.widthController,
    required this.heightController,
  });

  final int percentage;
  final ImageData? sourceImage;
  final TextEditingController widthController;
  final TextEditingController heightController;
  final Function({int? width, int? height}) updateSize;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text('$percentage%'),
      selected: false,
      onSelected: (_) {
        if (sourceImage != null) {
          final sourceWidth = sourceImage?.width ?? 0;
          final sourceHeight = sourceImage?.height ?? 0;

          final newWidth = (sourceWidth * (100 - percentage) / 100).round();
          final newHeight = (sourceHeight * (100 - percentage) / 100).round();

          widthController.text = newWidth.toString();
          heightController.text = newHeight.toString();

          updateSize.call(width: newWidth, height: newHeight);
        }
      },
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedColor: Theme.of(
        context,
      ).colorScheme.primary.withValues(alpha: 0.2),
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
