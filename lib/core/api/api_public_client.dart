import 'api_base_client.dart';

class ApiPublicClient extends BaseDioClient {
  ApiPublicClient();


  @override
  Future<String> getToken() async {
    return '';
  }
}