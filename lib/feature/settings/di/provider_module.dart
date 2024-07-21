import 'package:get_it/get_it.dart';

import '../presentation/providers/setting_provider.dart';


initProvider(GetIt sl) {
  sl.registerFactory(
    () => SettingProvider(
      getInfoDeviceUseCase: sl(),
      getDarkModeUseCase: sl(), 
      setDarkModeUseCase: sl(),
    ),
  );
}
