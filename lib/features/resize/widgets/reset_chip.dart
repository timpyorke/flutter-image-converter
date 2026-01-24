import 'package:flutter/material.dart';
import 'package:flutter_image_converters/data/image_data.dart';

class ResetChip extends StatelessWidget {
  const ResetChip({
    super.key,
    this.sourceImage,
    required this.widthController,
    required this.heightController,
    required this.updateSize,
  });

  final ImageData? sourceImage;
  final TextEditingController widthController;
  final TextEditingController heightController;
  final Function({int? width, int? height}) updateSize;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.refresh_rounded, size: 16),
          SizedBox(width: 4),
          Text('Reset'),
        ],
      ),
      selected: false,
      onSelected: (_) {
        if (sourceImage != null) {
          final sourceWidth = sourceImage!.width ?? 0;
          final sourceHeight = sourceImage!.height ?? 0;

          widthController.text = sourceWidth.toString();
          heightController.text = sourceHeight.toString();

          updateSize.call(width: sourceWidth, height: sourceHeight);
        }
      },
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedColor: Theme.of(
        context,
      ).colorScheme.secondary.withValues(alpha: 0.2),
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide(
        color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3),
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
