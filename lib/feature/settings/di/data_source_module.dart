import 'package:get_it/get_it.dart';

import '../data/datasources/setting_local_data_sources.dart';


initDataSource(GetIt sl) {
  sl.registerLazySingleton<SettingLocalDatasource>(
    () => SettingLocalDatasourceImpl(
      sharedPreferences: sl(),
    ),
  );

}
