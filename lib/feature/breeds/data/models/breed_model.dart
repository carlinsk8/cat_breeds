import '../../domain/entities/breed.dart';

class BreedModel extends Breed {
  BreedModel({
    required super.id, 
    required super.name, 
    required super.cfaUrl, 
    required super.vetstreetUrl, 
    required super.vcahospitalsUrl, 
    required super.temperament, 
    required super.origin, 
    required super.description, 
    required super.altNames, 
    required super.childFriendly, 
    required super.dogFriendly, 
    required super.intelligence, 
    required super.socialNeeds,
  });

  factory BreedModel.fromJson(Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) {
      return BreedModel(
        id: '',
        name: '',
        cfaUrl: '',
        vetstreetUrl: '',
        vcahospitalsUrl: '',
        temperament: '',
        origin: '',
        description: '',
        altNames: '',
        childFriendly: 0,
        dogFriendly: 0,
        intelligence: 0,
        socialNeeds: 0,
      );
    }
    
    return BreedModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      cfaUrl: json['cfa_url'] ?? '',
      vetstreetUrl: json['vetstreet_url'] ?? '',
      vcahospitalsUrl: json['vcahospitals_url'] ?? '',
      temperament: json['temperament'] ?? '',
      origin: json['origin'] ?? '',
      description: json['description'] ?? '',
      altNames: json['alt_names'] ?? '',
      childFriendly: json['child_friendly'] ?? 0,
      dogFriendly: json['dog_friendly'] ?? 0,
      intelligence: json['intelligence'] ?? 0,
      socialNeeds: json['social_needs'] ?? 0,
    );
  }

}