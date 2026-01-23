import 'package:flutter/material.dart';
import 'package:flutter_image_converters/l10n/app_localizations.dart';

enum ThemeType {
  light(Icons.light_mode_rounded, ThemeMode.light),
  dark(Icons.dark_mode_rounded, ThemeMode.dark),
  system(Icons.brightness_auto_rounded, ThemeMode.system);

  final IconData icon;
  final ThemeMode mode;

  const ThemeType(this.icon, this.mode);

  String getLabel(BuildContext context) {
    switch (this) {
      case ThemeType.light:
        return AppLocalizations.of(context)?.light ?? 'Light';
      case ThemeType.dark:
        return AppLocalizations.of(context)?.dark ?? 'Dark';
      case ThemeType.system:
        return AppLocalizations.of(context)?.system ?? 'System';
    }
  }
}
