import '../domain/usecases/get_dark_mode_use_case.dart';
import '../domain/usecases/set_dart_mode_use_case.dart';
import 'package:get_it/get_it.dart';

import '../domain/usecases/get_info_device_use_case.dart';

initUseCase(GetIt sl) {
  sl.registerLazySingleton(
    () => GetInfoDeviceUseCase(settingRepository: sl()),
  );
  sl.registerLazySingleton(
    () => GetDarkModeUseCase(settingRepository: sl()),
  );
  sl.registerLazySingleton(
    () => SetDarkModeUseCase(settingRepository: sl()),
  );
}