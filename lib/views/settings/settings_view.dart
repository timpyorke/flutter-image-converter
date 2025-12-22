import 'package:flutter/material.dart';
import 'package:flutter_image_converters/views/settings/setting_about_card.dart';
import 'package:flutter_image_converters/views/settings/setting_advanced_card.dart';
import 'package:flutter_image_converters/views/settings/setting_default_format_card.dart';
import 'package:flutter_image_converters/views/settings/setting_default_quality_card.dart';
import 'package:flutter_image_converters/views/settings/setting_storage_card.dart';
import 'package:flutter_image_converters/views/settings/setting_theme_card.dart';
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
                    _showStorageLocationDialog(context, viewModel, l10n);
                  },
                ),
                const SizedBox(height: 32),

                // Advanced Section
                SectionTitle(title: l10n.advanced),
                const SizedBox(height: 12),
                SettingAdvancedCard(
                  language: _getLanguageName(viewModel.language),
                  showLanguageDialog: () {
                    _showLanguageDialog(context, viewModel, l10n);
                  },
                  showClearCacheDialog: () {
                    _showClearCacheDialog(context, l10n);
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
                    onPressed: () => _showResetDialog(context, viewModel, l10n),
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

  void _showResetDialog(
    BuildContext context,
    SettingsViewModel viewModel,
    AppLocalizations l10n,
  ) {
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
                  color: Colors.red.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.warning_rounded,
                  color: Colors.red.shade600,
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Reset Settings?',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Text(
                'This will reset all settings to their default values. This action cannot be undone.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GlassContainer(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      borderRadius: 12,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GradientButton(
                      onPressed: () {
                        viewModel.resetToDefaults();
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Settings reset to defaults'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                      child: const Text('Reset'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context, AppLocalizations l10n) {
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
                  Icons.delete_sweep_rounded,
                  color: Colors.white,
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Clear Cache?',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Text(
                'This will clear temporary files and free up storage space. Your images and settings will not be affected.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GlassContainer(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      borderRadius: 12,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GradientButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Cache cleared successfully'),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green.shade600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                      child: const Text('Clear'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getLanguageName(String code) {
    const languages = {
      'en': 'English',
      'th': 'ภาษาไทย',
      'zh': '中文',
      'ja': '日本語',
      'ko': '한국어',
      'es': 'Español',
      'fr': 'Français',
      'de': 'Deutsch',
      'pt': 'Português',
      'ru': 'Русский',
    };
    return languages[code] ?? 'English';
  }

  void _showLanguageDialog(
    BuildContext context,
    SettingsViewModel viewModel,
    AppLocalizations l10n,
  ) {
    final languages = [
      {'code': 'en', 'name': 'English', 'nativeName': 'English'},
      {'code': 'th', 'name': 'Thai', 'nativeName': 'ภาษาไทย'},
      {'code': 'zh', 'name': 'Chinese', 'nativeName': '中文'},
      {'code': 'ja', 'name': 'Japanese', 'nativeName': '日本語'},
      {'code': 'ko', 'name': 'Korean', 'nativeName': '한국어'},
      {'code': 'es', 'name': 'Spanish', 'nativeName': 'Español'},
      {'code': 'fr', 'name': 'French', 'nativeName': 'Français'},
      {'code': 'de', 'name': 'German', 'nativeName': 'Deutsch'},
      {'code': 'pt', 'name': 'Portuguese', 'nativeName': 'Português'},
      {'code': 'ru', 'name': 'Russian', 'nativeName': 'Русский'},
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
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.language_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Select Language',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 400,
                width: double.infinity,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: languages.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final language = languages[index];
                    final isSelected = viewModel.language == language['code'];

                    return InkWell(
                      onTap: () {
                        viewModel.updateLanguage(language['code']!);
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Language changed to ${language['nativeName']}',
                            ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.15)
                              : Theme.of(
                                  context,
                                ).colorScheme.surface.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(
                                    context,
                                  ).colorScheme.outline.withValues(alpha: 0.2),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    language['nativeName']!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
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
                                    language['name']!,
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
