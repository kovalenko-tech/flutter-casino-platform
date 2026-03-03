import 'package:flutter/material.dart';

import 'package:flutter_casino_platform/app.dart';
import 'package:flutter_casino_platform/core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(CasinoApp());
}
