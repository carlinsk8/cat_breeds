

import '../../domain/entities/image_breed.dart';
import 'breed_model.dart';

class ImageBreedModel extends ImageBreed {
  ImageBreedModel({
    required super.id,
    required super.url,
    required super.breed,
  });

  factory ImageBreedModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ImageBreedModel(
        id: '',
        url: '',
        breed: [BreedModel.fromJson(null)],
      );
    } else {
      return ImageBreedModel(
        id: json['id'] ?? '',
        url: json['url'] ?? '',
        breed: json['breeds'] !=null 
        ? (json['breeds'] as List<dynamic>).map((x) => BreedModel.fromJson(x)).toList()
        : [], // Wrap the BreedModel object in a list
      );
    }
  }
}