import 'package:flutter/material.dart';

import 'app.dart';
import '/di/injection_feature.dart' as di;
import 'routes.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init dependency injection.
  await di.init();
  // init routes.
  AppRoute.init();
  runApp(const App());
}