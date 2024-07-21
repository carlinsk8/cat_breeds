import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/models/response_model.dart';
import '../../domain/entities/breed.dart';
import '../../domain/entities/image_breed.dart';
import '../../domain/repositories/breed_repository.dart';
import '../datasources/breeds_data_sources.dart';
import '../models/breed_model.dart';
import '../models/image_model.dart';

class BreedRepositoryImpl extends BreedRepository {

  final BreedsDataSources breedsDataSources;

  BreedRepositoryImpl({required this.breedsDataSources});

  @override
  Future<Either<Failure, List<Breed>>> getBreeds({
    required String limit, 
    required String page,
  }) async {
    try {
      final body = await breedsDataSources.getBreeds(
        limit: limit, 
        page: page
      );
      // if (body.status == 'error') {
      //    return Left(UnexpectedFailure(message: body.message));
      // }
      final data = (body.data as List).map((e) => BreedModel.fromJson(e)).toList();
      return Right(data);
    } catch (e, _) {
      return Left(UnexpectedFailure(message: _responseError(e)));
    }
  }
  
  @override
  Future<Either<Failure, ImageBreed?>> getImageById(String id) async {
    try {
      final body = await breedsDataSources.getImageById(id);
      // if (body.status == 'error') {
      //    return Left(UnexpectedFailure(message: body.message));
      // }
      final data = ImageBreedModel.fromJson(body.data);
      return Right(data);
    } catch (e, _) {
      return Left(UnexpectedFailure(message: _responseError(e)));
    }
    
  }
  
  @override
  Future<Either<Failure, List<ImageBreed>>> getImagesBreeds({
    required String limit, 
    required String page, 
    required List<String> breedIds, 
    required String order
  }) async {
    // try {
      final body = await breedsDataSources.getImagesBreeds(
        limit: limit, 
        page: page, 
        breedIds: breedIds, 
        order: order
      );
      // if (body.status == 'error') {
      //    return Left(UnexpectedFailure(message: body.message));
      // }
      final data = (body.data as List).map((e) => ImageBreedModel.fromJson(e)).toList();
      return Right(data);
    // } catch (e, _) {
    //   return Left(UnexpectedFailure(message: _responseError(e)));
    // }
  }

  String? _responseError(Object e) {
    final error = e as AppException;
    try {
      final data = ResponseModel.fromJson(json.decode(error.message??''));
      return data.toString();
    } catch (e) {
      return error.message ;
    }
  }

}