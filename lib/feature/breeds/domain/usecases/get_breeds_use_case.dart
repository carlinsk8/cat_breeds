import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/breed.dart';
import '../repositories/breed_repository.dart';

class GetBreedsUseCase extends UseCase<List<Breed>, GetBreedsUseCaseParams> {
  final BreedRepository breedRepository;

  GetBreedsUseCase({required this.breedRepository});

  @override
  Future<Either<Failure, List<Breed>>> call(GetBreedsUseCaseParams params,{Callback? callback}) 
  => breedRepository.getBreeds(
    limit: params.limit,
    page: params.page,  
  );
}

class GetBreedsUseCaseParams {
  final String limit;
  final String page;

  GetBreedsUseCaseParams({
    this.limit = '25',
    this.page = '0',
  });
}