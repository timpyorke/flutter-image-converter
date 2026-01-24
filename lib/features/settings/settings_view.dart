import 'package:flutter/material.dart';
import 'package:flutter_image_converters/features/settings/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import 'settings_viewmodel.dart';
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
              spacing: 24,
              children: [
                // Appearance Section
                SectionTitle(
                  title: l10n.appearance,
                  body: [
                    SettingThemeCard(
                      lable: l10n.theme,
                      updateThemeMode: (type) {
                        viewModel.updateThemeMode(type.mode);
                      },
                      currentThemeMode: viewModel.themeMode,
                      description: l10n.choosePreferredTheme,
                    ),
                  ],
                ),

                // Storage Section
                SectionTitle(
                  title: l10n.storage,
                  body: [
                    SettingStorageCard(
                      toggleSaveToGallery: viewModel.toggleSaveToGallery,
                      saveToGallery: viewModel.saveToGallery,
                      storageLocation: viewModel.storageLocation,
                      showStorageLocation: () {
                        viewModel.showStorageLocationDialog(context);
                      },
                    ),
                  ],
                ),

                // Advanced Section
                SectionTitle(
                  title: l10n.advanced,
                  body: [
                    SettingAdvancedCard(
                      language: viewModel.getLanguageName(),
                      showLanguageDialog: () {
                        viewModel.showLanguageDialog(context);
                      },
                      showClearCacheDialog: () {
                        viewModel.onShowClearCacheDialog(context);
                      },
                    ),
                  ],
                ),

                // About Section
                SectionTitle(
                  title: l10n.about,
                  body: [
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
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
