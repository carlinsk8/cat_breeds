class Breed {
  String id;
  String name;
  String? cfaUrl;
  String? vetstreetUrl;
  String? vcahospitalsUrl;
  String? temperament;
  String? origin;
  String? description;
  String? altNames;
  int? childFriendly;
  int? dogFriendly;
  int? intelligence;
  int? socialNeeds;

  Breed({
    required this.id,
    required this.name,
     this.cfaUrl,
     this.vetstreetUrl,
     this.vcahospitalsUrl,
     this.temperament,
     this.origin,
     this.description,
     this.altNames,
     this.childFriendly,
     this.dogFriendly,
     this.intelligence,
     this.socialNeeds,
  });

}