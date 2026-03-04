import 'package:flutter/material.dart';

import 'package:flutter_casino_platform/app.dart';
import 'package:flutter_casino_platform/core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise SQLite DB and register all service-locator dependencies.
  await initDependencies();

  runApp(CasinoApp());
}
