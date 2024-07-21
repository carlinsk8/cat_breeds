import '../entities/breed.dart';
import '../entities/image_breed.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class BreedRepository {
  Future<Either<Failure, List<Breed>>> getBreeds({
    required String limit, 
    required String page,
  });
  Future<Either<Failure, List<ImageBreed>>> getImagesBreeds({
    required String limit,
    required String page,
    required List<String> breedIds,
    required String order,
  });
  Future<Either<Failure, ImageBreed?>> getImageById(String id);
}