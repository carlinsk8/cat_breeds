import 'package:get_it/get_it.dart';

import '../data/repositories/setting_repository_impl.dart';
import '../domain/repositories/setting_repository.dart';


initRepository(GetIt sl) {

  sl.registerLazySingleton<SettingRepository>(
    () => SettingRepositoryImpl(
      settingLocalDatasource: sl(),
    ),
  );

}
