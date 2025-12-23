import 'package:flutter/material.dart';
import 'package:flutter_image_converters/views/settings/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../viewmodels/settings_viewmodel.dart';
import '../../core/widgets/widgets.dart';
import '../legal/privacy_policy_view.dart';
import '../legal/terms_of_service_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<SettingsViewModel>(
        builder: (context, viewModel, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Appearance Section
                SectionTitle(title: l10n.appearance),
                const SizedBox(height: 12),
                SettingThemeCard(
                  lable: l10n.theme,
                  updateThemeMode: (type) {
                    viewModel.updateThemeMode(type.mode);
                  },
                  currentThemeMode: viewModel.themeMode,
                  description: l10n.choosePreferredTheme,
                ),
                const SizedBox(height: 32),

                // Conversion Defaults Section
                SectionTitle(title: l10n.conversionDefaults),
                const SizedBox(height: 12),
                SettingDefaultFormatCard(
                  defaultFormat: viewModel.defaultFormat,
                  updateDefaultFormat: (format) {
                    viewModel.updateDefaultFormat(format);
                  },
                ),
                const SizedBox(height: 16),
                SettingDefaultQualityCard(
                  defaultQuality: viewModel.defaultQuality,
                  updateDefaultQuality: (quality) {
                    viewModel.updateDefaultQuality(quality);
                  },
                ),
                const SizedBox(height: 32),

                // Storage Section
                SectionTitle(title: l10n.storage),
                const SizedBox(height: 12),
                SettingStorageCard(
                  toggleSaveToGallery: viewModel.toggleSaveToGallery,
                  saveToGallery: viewModel.saveToGallery,
                  storageLocation: viewModel.storageLocation,
                  showStorageLocation: () {
                    viewModel.showStorageLocationDialog(context);
                  },
                ),
                const SizedBox(height: 32),

                // Advanced Section
                SectionTitle(title: l10n.advanced),
                const SizedBox(height: 12),
                SettingAdvancedCard(
                  language: viewModel.getLanguageName(),
                  showLanguageDialog: () {
                    viewModel.showLanguageDialog(context);
                  },
                  showClearCacheDialog: () {
                    viewModel.onShowClearCacheDialog(context);
                  },
                ),
                const SizedBox(height: 32),

                // About Section
                SectionTitle(title: l10n.about),
                const SizedBox(height: 12),
                SettingAboutCard(
                  version: viewModel.version,
                  onTapPrivacyPolicy: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyView(),
                      ),
                    );
                  },
                  onTapTermsOfService: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TermsOfServiceView(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),

                // Reset Button
                Center(
                  child: GradientButton(
                    onPressed: () {
                      viewModel.onShowResetDialog(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.restore_rounded, color: Colors.white),
                        const SizedBox(width: 12),
                        Text(l10n.resetToDefaults),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showStorageLocationDialog(
    BuildContext context,
    SettingsViewModel viewModel,
    AppLocalizations l10n,
  ) {
    final storageOptions = [
      {
        'title': 'Pictures/ImageConverter',
        'subtitle': 'Default location in Pictures folder',
        'path': 'Pictures/ImageConverter',
      },
      {
        'title': 'Downloads/ImageConverter',
        'subtitle': 'Converted images in Downloads',
        'path': 'Downloads/ImageConverter',
      },
      {
        'title': 'Documents/ImageConverter',
        'subtitle': 'Store in Documents folder',
        'path': 'Documents/ImageConverter',
      },
      {
        'title': 'DCIM/ImageConverter',
        'subtitle': 'Save with camera photos',
        'path': 'DCIM/ImageConverter',
      },
    ];

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.folder_rounded,
                  color: Colors.white,
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Storage Location',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Text(
                'Choose where to save converted images',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ...storageOptions.map((option) {
                final isSelected = viewModel.storageLocation == option['path'];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GlassContainer(
                    padding: const EdgeInsets.all(16),
                    borderRadius: 16,
                    child: InkWell(
                      onTap: () {
                        viewModel.updateStorageLocation(option['path']!);
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Storage location updated to ${option['title']}',
                            ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.primary.withValues(alpha: 0.2)
                                  : Theme.of(context).colorScheme.surface
                                        .withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.folder_rounded,
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onSurface
                                        .withValues(alpha: 0.6),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  option['title']!,
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w600,
                                        color: isSelected
                                            ? Theme.of(
                                                context,
                                              ).colorScheme.primary
                                            : null,
                                      ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  option['subtitle']!,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withValues(alpha: 0.6),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle_rounded,
                              color: Theme.of(context).colorScheme.primary,
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
