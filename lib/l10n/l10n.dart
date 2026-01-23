import 'package:flutter/widgets.dart';
import 'package:flutter_image_converters/l10n/app_localizations.dart';

export 'package:flutter_image_converters/l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
