import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/widgets/glass_card.dart';
import 'package:flutter_image_converters/l10n/l10n.dart';
import 'package:flutter_image_converters/views/settings/widgets/setting_tile.dart';

class SettingStorageCard extends StatelessWidget {
  const SettingStorageCard({
    super.key,
    required this.toggleSaveToGallery,
    required this.saveToGallery,
    required this.storageLocation,
    required this.showStorageLocation,
  });

  final bool saveToGallery;
  final String storageLocation;
  final VoidCallback toggleSaveToGallery;
  final VoidCallback showStorageLocation;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SettingTile(
            icon: Icons.save_alt_rounded,
            title: context.l10n.autoSaveToGallery,
            subtitle: context.l10n.automaticallySaveConverted,
            trailing: Switch(
              value: saveToGallery,
              onChanged: (_) => toggleSaveToGallery(),
              activeTrackColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          SettingTile(
            icon: Icons.folder_rounded,
            title: context.l10n.storageLocation,
            subtitle: storageLocation,
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            onTap: showStorageLocation,
          ),
        ],
      ),
    );
  }
}
