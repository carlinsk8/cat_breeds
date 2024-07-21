import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/image_breed.dart';
import '../repositories/breed_repository.dart';

class GestImagesBreedsUseCase extends UseCase<List<ImageBreed>, GestImagesBreedsUseCaseParams> {
  final BreedRepository breedRepository;

  GestImagesBreedsUseCase({required this.breedRepository});

  @override
  Future<Either<Failure, List<ImageBreed>>> call(GestImagesBreedsUseCaseParams params,{Callback? callback}) 
  => breedRepository.getImagesBreeds(
    limit: params.limit,
    page: params.page,
    breedIds: params.breedIds,
    order: params.order,
  );
}

class GestImagesBreedsUseCaseParams {
  final String limit;
  final String page;
  final List<String> breedIds;
  final String order;

  GestImagesBreedsUseCaseParams({
    this.limit = '25',
    this.page = '0',
    this.breedIds = const [],
    this.order = 'ASC',
  });
}