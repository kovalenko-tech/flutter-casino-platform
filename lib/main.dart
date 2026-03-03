import 'package:flutter/material.dart';

import 'app.dart';
import 'core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise Isar DB and register all service-locator dependencies.
  await initDependencies();

  runApp(CasinoApp());
}
