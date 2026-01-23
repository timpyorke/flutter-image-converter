import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app.dart';
import 'core/di/service_locator.dart';
import 'flavors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  // Initialize dependency injection
  await setupDependencyInjection();

  F.appFlavor = Flavor.dev;

  runApp(const App());
}
