import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/models/response_model.dart';

abstract class SettingLocalDatasource {
  Future<ResponseModel> getInfoDevice();
  Future<ResponseModel> getDardMode();
  Future<ResponseModel> setDardMode(bool value);
}

class SettingLocalDatasourceImpl extends SettingLocalDatasource {
  final SharedPreferences sharedPreferences;
  static const darkModeStorage= 'darkMode';
  static const platform = MethodChannel('pragma.catbreeds.dev/version');

  SettingLocalDatasourceImpl({required this.sharedPreferences});
  @override
  Future<ResponseModel> getInfoDevice() async {
    final Map<dynamic, dynamic> result = await platform.invokeMethod('getVersionName');
    final body = ResponseModel.fromJson(result);
    return body;
  }
  
  @override
  Future<ResponseModel> getDardMode() async  {
    final result = sharedPreferences.getBool(darkModeStorage);
    final body = ResponseModel.fromJson(result??false);
    return body;
  }
  
  @override
  Future<ResponseModel> setDardMode(bool value) async{
    final result = await sharedPreferences.setBool(darkModeStorage, value);
    final body = ResponseModel.fromJson(result);
    return body;
  }
}