import 'package:get_it/get_it.dart';

import '../data/datasources/breeds_data_sources.dart';

initDataSource(GetIt sl) {
  sl.registerLazySingleton<BreedsDataSources>(
    () => BreedsDataSourcesImpl(
      apiAuthClient: sl(),
      apiPublicClient: sl(),
      
    ),
  );

}
