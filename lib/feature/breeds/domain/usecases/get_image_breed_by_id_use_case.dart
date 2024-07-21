import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/image_breed.dart';
import '../repositories/breed_repository.dart';

class GestImageBreedByIdUseCase extends UseCase<ImageBreed?, String> {
  final BreedRepository breedRepository;

  GestImageBreedByIdUseCase({required this.breedRepository});

  @override
  Future<Either<Failure, ImageBreed?>> call(String params,{Callback? callback}) 
  => breedRepository.getImageById(params);
}

