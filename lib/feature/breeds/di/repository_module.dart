import 'package:get_it/get_it.dart';

import '../data/repositories/breed_repository_impl.dart';
import '../domain/repositories/breed_repository.dart';


initRepository(GetIt sl) {

  sl.registerLazySingleton<BreedRepository>(
    () => BreedRepositoryImpl(
      breedsDataSources: sl(),
    ),
  );

}
