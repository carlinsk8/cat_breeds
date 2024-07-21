abstract class AppException implements Exception {
  final String? _message;
  final dynamic _prefix;

  AppException([this._message, this._prefix]);

  String? get message => _message;

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class ServerException extends AppException {
  ServerException([String? message])
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, 'Unauthorised: ');
}

class NotTokenException extends AppException {
  NotTokenException([String? message]) : super(message, 'Error No token: ');
}




