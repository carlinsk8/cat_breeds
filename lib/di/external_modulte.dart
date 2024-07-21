import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

initExternal(GetIt sl) async {
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
 
}