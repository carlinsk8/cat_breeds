import '../utils/env.dart';
import 'api_base_client.dart';

class ApiAuthClient extends BaseDioClient {
  ApiAuthClient();


  @override
  Future<String> getToken() async {
    return Env.token;
  }
}