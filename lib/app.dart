import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/config/themes.dart';
import 'package:flutter_image_converters/core/di/service_locator.dart';
import 'package:flutter_image_converters/core/widgets/flavor_banner.dart';
import 'package:flutter_image_converters/l10n/app_localizations.dart';
import 'package:flutter_image_converters/features/home/home_view.dart';
import 'package:flutter_image_converters/features/convert/conversion_viewmodel.dart';
import 'package:flutter_image_converters/features/home/home_viewmodel.dart';
import 'package:flutter_image_converters/features/resize/resize_viewmodel.dart';
import 'package:flutter_image_converters/features/settings/settings_viewmodel.dart';
import 'package:flutter_image_converters/features/tutorial/tutorial_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<NavigationViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<ConversionViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<ResizeViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<SettingsViewModel>()),
      ],
      child: Consumer<SettingsViewModel>(
        builder: (context, settingsVM, child) {
          return MaterialApp(
            title: F.title,
            theme: buildLightTheme(),
            darkTheme: buildDarkTheme(),
            themeMode: settingsVM.themeMode,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('th'), // Thai
              Locale('zh'), // Chinese
              Locale('ja'), // Japanese
              Locale('ko'), // Korean
              Locale('es'), // Spanish
              Locale('fr'), // French
              Locale('de'), // German
              Locale('pt'), // Portuguese
              Locale('ru'), // Russian
            ],
            locale: Locale(settingsVM.settings.language),
            home: FlavorBanner(
              show: kDebugMode,
              child: settingsVM.settings.hasSeenTutorial
                  ? const HomePage()
                  : const TutorialView(),
            ),
          );
        },
      ),
    );
  }
}
