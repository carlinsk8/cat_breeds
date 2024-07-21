import 'feature/breeds/routes/breeds_route.dart';
import 'feature/settings/routes/setting_route.dart';

class AppRoute {
  static init() {
    initBreeds();
    initSetting();
  }
}