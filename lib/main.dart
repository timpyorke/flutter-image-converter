import 'package:flutter/material.dart';

import 'app.dart';
import 'core/di/service_locator.dart';
import 'flavors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await setupDependencyInjection();

  F.appFlavor = Flavor.prod;

  runApp(const App());
}
