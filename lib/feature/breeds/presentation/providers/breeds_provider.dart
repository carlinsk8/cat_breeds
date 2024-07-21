import '../../domain/entities/image_breed.dart';
import '../../domain/usecases/get_breeds_use_case.dart';
import '../../domain/usecases/get_image_breed_by_id_use_case.dart';
import '../../domain/usecases/get_images_breeds_use_case.dart';
import 'package:flutter/widgets.dart';

import '../../../../shared/view_state.dart';
import '../../domain/entities/breed.dart';

class BreedsProvider extends ChangeNotifier {
  final GetBreedsUseCase getBreedsUseCase;
  final GestImagesBreedsUseCase getImagesBreedsUseCase;
  final GestImageBreedByIdUseCase getImageBreedByIdUseCase;

  BreedsProvider({
    required this.getBreedsUseCase, 
    required this.getImagesBreedsUseCase, 
    required this.getImageBreedByIdUseCase,
  });

  List<Breed> listBreed = [];
  List<ImageBreed> listImageBreed = [];
  ImageBreed? imageBreed;
  ViewState state = Idle();


  Future<void> getListBreed() async {
    final params = GetBreedsUseCaseParams();
    state = Loading();
    
    notifyListeners();
    final result = await getBreedsUseCase(params);
    result.fold(
      (failure) => state = Error(failure: failure),
      (data) {
        state = Loaded(value: data);
        listBreed = data;
      },
    );
    notifyListeners();
  }

  Future<int> getListImagesBreeds([String? id, int page = 0]) async {
      final params = GestImagesBreedsUseCaseParams(
        breedIds: (id != null) ? [id] : [],
        page: page.toString(),
      );
      state = Loading();
      notifyListeners();
      var list;
      final result = await getImagesBreedsUseCase(params);
      result.fold(
        (failure) => state = Error(failure: failure),
        (data) {
          state = Loaded(value: data);
          list = data;
          if (page == 0) {
            listImageBreed = data;
          } else {
            listImageBreed.addAll(data);
          }
        },
      );
      notifyListeners();
      return list.length;
    }

    Future<void> getImageBreed(String id) async {
      state = Loading();
      notifyListeners();
      final result = await getImageBreedByIdUseCase(id);
      result.fold(
        (failure) => state = Error(failure: failure),
        (data) {
          state = Loaded(value: data);
          imageBreed = data;
        },
      );
      notifyListeners();
    }
  

}