import 'package:get_it/get_it.dart';

import '../presentation/providers/breeds_provider.dart';


initProvider(GetIt sl) {
  sl.registerFactory(
    () => BreedsProvider(
      getBreedsUseCase: sl(), 
      getImagesBreedsUseCase: sl(), 
      getImageBreedByIdUseCase: sl(),
    ),
  );
}
