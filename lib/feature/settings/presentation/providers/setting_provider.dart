import 'package:flutter/widgets.dart';

import '../../../../core/usecases/use_case.dart';
import '../../domain/usecases/get_dark_mode_use_case.dart';
import '../../domain/usecases/get_info_device_use_case.dart';
import '../../domain/usecases/set_dart_mode_use_case.dart';

class SettingProvider extends ChangeNotifier {
  final GetInfoDeviceUseCase getInfoDeviceUseCase;
  final GetDarkModeUseCase getDarkModeUseCase;
  final SetDarkModeUseCase setDarkModeUseCase;

  SettingProvider({
    required this.getInfoDeviceUseCase,
    required this.getDarkModeUseCase,
    required this.setDarkModeUseCase,
  });

  bool _isDarkMode = false;
  String _version = '';
  String get version => _version;
  bool get isDarkMode => _isDarkMode;

  Future<void> toggleDarkMode(value) async {
    _isDarkMode = value;
    await setDarkModeLocalStorage();
    
  }

  void getInfoDevice() async {
    final result = await getInfoDeviceUseCase(NoParams());
    result.fold((l) => _version ='', (info) => _version =info.versionName);
    notifyListeners();
  }

  Future<void> getDarkModeLocalStorage() async {
    final result = await getDarkModeUseCase(NoParams());
    result.fold((l){ 
      _isDarkMode = false;
      notifyListeners();
    }, (isDarkMode) {
      _isDarkMode = isDarkMode;
      notifyListeners();
    });
    
  }

  Future<void> setDarkModeLocalStorage() async {
    final result = await setDarkModeUseCase(_isDarkMode);
    result.fold((l){ 
      _isDarkMode = false;
      notifyListeners();
    }, (isDarkMode) {
      notifyListeners();
    });
  }
}