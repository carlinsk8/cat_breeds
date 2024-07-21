import 'package:get_it/get_it.dart';
import '../feature/breeds/di/auth_module.dart';
import '../feature/settings/di/setting_module.dart';
import 'core_module.dart';
import 'external_modulte.dart';

final sl = GetIt.instance;

init() async {
  await initExternal(sl);
  initCore(sl);
  initBreedsModule(sl);
  initSettingModule(sl);
}
