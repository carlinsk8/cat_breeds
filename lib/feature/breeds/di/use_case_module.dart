import '../domain/usecases/get_breeds_use_case.dart';
import '../domain/usecases/get_image_breed_by_id_use_case.dart';
import '../domain/usecases/get_images_breeds_use_case.dart';
import 'package:get_it/get_it.dart';

initUseCase(GetIt sl) {
  sl.registerLazySingleton(
    () => GetBreedsUseCase(breedRepository: sl()),
  );
  
  sl.registerLazySingleton(
    () => GestImagesBreedsUseCase(breedRepository: sl()),
  );

  sl.registerLazySingleton(
    () => GestImageBreedByIdUseCase(breedRepository: sl()),
  );
}
