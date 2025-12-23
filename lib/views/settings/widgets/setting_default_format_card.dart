import 'package:flutter/material.dart';
import 'package:flutter_image_converters/const/image_format.dart';
import 'package:flutter_image_converters/core/widgets/glass_card.dart';

class SettingDefaultFormatCard extends StatelessWidget {
  const SettingDefaultFormatCard({
    super.key,
    required this.defaultFormat,
    required this.updateDefaultFormat,
  });

  final ImageFormat defaultFormat;
  final Function(ImageFormat) updateDefaultFormat;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.image_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Default Output Format',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ImageFormat.values.map((format) {
              final isSelected = defaultFormat == format;
              return GestureDetector(
                onTap: () => updateDefaultFormat(format),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary,
                            ],
                          )
                        : null,
                    color: isSelected
                        ? null
                        : Theme.of(
                            context,
                          ).colorScheme.surface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : Theme.of(
                              context,
                            ).colorScheme.outline.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    format.name.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: isSelected
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
