import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/const/theme_type.dart';
import 'package:flutter_image_converters/core/widgets/glass_card.dart';
import 'package:flutter_image_converters/presentation/views/settings/widgets/setting_theme_option.dart';

class SettingThemeCard extends StatelessWidget {
  const SettingThemeCard({
    super.key,
    required this.lable,
    required this.updateThemeMode,
    required this.currentThemeMode,
    required this.description,
  });

  final String lable;
  final String description;
  final ThemeMode currentThemeMode;
  final Function(ThemeType) updateThemeMode;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.2),
                      Theme.of(
                        context,
                      ).colorScheme.secondary.withValues(alpha: 0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.palette_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lable,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      lable,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            spacing: 12,
            children: [
              ...ThemeType.values.map(
                (element) => Expanded(
                  child: SettingThemeOption(
                    icon: element.icon,
                    label: element.getLabel(context),
                    isSelected: element.mode == currentThemeMode,
                    onTap: () {
                      updateThemeMode(element);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
