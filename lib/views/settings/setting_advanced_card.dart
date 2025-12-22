import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/widgets/glass_card.dart';
import 'package:flutter_image_converters/views/settings/setting_tile.dart';

class SettingAdvancedCard extends StatelessWidget {
  const SettingAdvancedCard({
    super.key,
    required this.language,
    required this.showLanguageDialog,
    required this.showClearCacheDialog,
  });

  final String language;
  final VoidCallback showLanguageDialog;
  final VoidCallback showClearCacheDialog;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SettingTile(
            icon: Icons.language_rounded,
            title: 'Language',
            subtitle: language,
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            onTap: () => showLanguageDialog,
          ),
          const SizedBox(height: 16),
          SettingTile(
            icon: Icons.delete_sweep_rounded,
            title: 'Clear Cache',
            subtitle: 'Free up storage space',
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            onTap: () => showClearCacheDialog,
          ),
        ],
      ),
    );
  }
}
