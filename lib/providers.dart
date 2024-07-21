
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'di/injection_feature.dart';
import 'feature/breeds/presentation/providers/breeds_provider.dart';
import 'feature/settings/presentation/providers/setting_provider.dart';

class Providers {
  static List<SingleChildWidget>  list = [
    ListenableProvider<BreedsProvider>(create: (_) => sl<BreedsProvider>()),
    ListenableProvider<SettingProvider>(create: (_) => sl<SettingProvider>()),
  ];
}