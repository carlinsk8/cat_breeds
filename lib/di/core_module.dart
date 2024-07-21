import 'package:get_it/get_it.dart';

import '../core/api/api_auth_client.dart';
import '../core/api/api_public_client.dart';


initCore(GetIt sl) {
  sl.registerLazySingleton(
    () => ApiAuthClient(),
  );

  sl.registerLazySingleton(
    () => ApiPublicClient(),
  );


}
