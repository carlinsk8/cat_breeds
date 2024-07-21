

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../error/exception.dart';

abstract class BaseDioClient {
  late Dio _instance;

  Future<String> getToken();
  Future<Dio> getDio([Map<String, dynamic>? cuyApiAux]) async {
    final token = await _getToken();
    final tokenChecked = await checkToken(token);
    _instance = Dio();
    _instance.options.receiveDataWhenStatusError = true;
    _instance.options.headers = {
      if(tokenChecked.isNotEmpty)'x-api-key':tokenChecked,
    };

    if (kDebugMode) _instance.interceptors.add(LogInterceptor());

    return _instance;
  }
  Future<String> checkToken(String token) async {
    return _getToken();
  }
  Future<String> _getToken() async {
    String token = await getToken();
    return token;
  }
  Future<Response> getUri(String url, {Map<String, dynamic>? queryParameters}) async {
    await getDio();
    return _processResponse(() => _instance.get(url, queryParameters: queryParameters));
  }

  Future<Response> _processResponse(DioAction action) async {
    try {
      final response = await action();
      return response;
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.badResponse) {
          final response = e.response;
          final statusCode = response?.statusCode;

          switch (statusCode) {
            case HttpStatus.unauthorized:
              throw UnauthorisedException(json.encode(response?.data));
            default:
              throw ServerException(json.encode(response?.data));
          }
        } else {
          throw ServerException(
              'Error occured while Communication with Server');
        }
      } else {
        e  as DioException;
        final error = e.error as DioException;
        throw ServerException(error.message);
      }
    }
  }
}

typedef DioAction = Future<Response> Function();

class LogInterceptor extends Interceptor {
  late DateTime beginTime;
  late DateTime endTime;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    beginTime = DateTime.now();
    print('<<HTTP>> ************************INIT*REQUEST***************************');
    print('<<HTTP>> REQUEST: ${options.method} <-- ${options.uri.toString()}');
    print('<<HTTP>> HEADERS: ${options.headers.toString()}');
    print('<<HTTP>> BODY: ${options.data.toString()}');
    print('<<HTTP>> ************************END*REQUEST***************************');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    endTime = DateTime.now();

    print('<<HTTP>> **************************INIT*RESPONSE*************************');
    print('<<HTTP>> RESPONSE URL: ${response.requestOptions.uri.toString()}');
    print('<<HTTP>> RESPONSE: ${response.data.toString()}');
    print('<<HTTP>> RESPONSE: status code: ${response.statusCode}');
    print('<<HTTP>> RESPONSE: execution time: ${beginTime.difference(endTime).inMilliseconds.abs()} milliseconds');
    print('<<HTTP>> **************************END*RESPONSE*************************');
    
    super.onResponse(response, handler);
  }
}