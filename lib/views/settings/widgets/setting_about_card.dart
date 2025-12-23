import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/widgets/glass_card.dart';
import 'package:flutter_image_converters/views/settings/widgets/setting_tile.dart';

class SettingAboutCard extends StatelessWidget {
  const SettingAboutCard({
    super.key,
    required this.version,
    required this.onTapPrivacyPolicy,
    required this.onTapTermsOfService,
  });

  final String version;
  final VoidCallback onTapPrivacyPolicy;
  final VoidCallback onTapTermsOfService;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SettingTile(
            icon: Icons.info_rounded,
            title: 'Version',
            subtitle: version,
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Latest',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SettingTile(
            icon: Icons.privacy_tip_rounded,
            title: 'Privacy Policy',
            subtitle: 'How we handle your data',
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            onTap: onTapPrivacyPolicy,
          ),
          const SizedBox(height: 16),
          SettingTile(
            icon: Icons.description_rounded,
            title: 'Terms of Service',
            subtitle: 'App usage terms',
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            onTap: onTapTermsOfService,
          ),
        ],
      ),
    );
  }
}
