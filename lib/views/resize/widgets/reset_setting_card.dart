import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/widgets/glass_card.dart';
import 'package:flutter_image_converters/core/widgets/glass_container.dart';
import 'package:flutter_image_converters/models/image_data.dart';
import 'package:flutter_image_converters/views/resize/widgets/percentage_chip.dart';
import 'package:flutter_image_converters/views/resize/widgets/reset_chip.dart';

class ResetSettingCard extends StatelessWidget {
  const ResetSettingCard({
    super.key,
    required this.maintainAspectRatio,
    required this.toggleAspectRatio,
    required this.widthController,
    required this.heightController,
    this.sourceImage,
  });

  final bool maintainAspectRatio;
  final VoidCallback toggleAspectRatio;
  final TextEditingController widthController;
  final TextEditingController heightController;
  final ImageData? sourceImage;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resize Settings',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),

          // Aspect Ratio Lock
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            borderRadius: 16,
            child: CheckboxListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.aspect_ratio_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  const Text('Maintain Aspect Ratio'),
                ],
              ),
              value: maintainAspectRatio,
              onChanged: (_) => toggleAspectRatio(),
              contentPadding: EdgeInsets.zero,
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ),

          const SizedBox(height: 20),

          // Quick Resize Options
          Text(
            'Reduce by %',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              PercentageChip(
                percentage: 25,
                sourceImage: sourceImage,
                updateSize: ({int? width, int? height}) {
                  if (width != null) {
                    widthController.text = width.toString();
                  }
                  if (height != null) {
                    heightController.text = height.toString();
                  }
                },
                widthController: widthController,
                heightController: heightController,
              ),
              PercentageChip(
                percentage: 50,
                sourceImage: sourceImage,
                updateSize: ({int? width, int? height}) {
                  if (width != null) {
                    widthController.text = width.toString();
                  }
                  if (height != null) {
                    heightController.text = height.toString();
                  }
                },
                widthController: widthController,
                heightController: heightController,
              ),
              PercentageChip(
                percentage: 75,
                sourceImage: sourceImage,
                updateSize: ({int? width, int? height}) {
                  if (width != null) {
                    widthController.text = width.toString();
                  }
                  if (height != null) {
                    heightController.text = height.toString();
                  }
                },
                widthController: widthController,
                heightController: heightController,
              ),
              ResetChip(
                sourceImage: sourceImage,
                widthController: widthController,
                heightController: heightController,
                updateSize: ({int? width, int? height}) {
                  if (width != null) {
                    widthController.text = width.toString();
                  }
                  if (height != null) {
                    heightController.text = height.toString();
                  }
                },
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Dimensions Input
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Width',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: widthController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.outline.withValues(alpha: 0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        suffixText: 'px',
                        filled: true,
                        fillColor: Theme.of(
                          context,
                        ).colorScheme.surface.withValues(alpha: 0.5),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Height',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: heightController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.outline.withValues(alpha: 0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        suffixText: 'px',
                        filled: true,
                        fillColor: Theme.of(
                          context,
                        ).colorScheme.surface.withValues(alpha: 0.5),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
