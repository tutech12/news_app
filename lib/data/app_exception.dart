class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class InternetException extends AppExceptions {
  InternetException([String? message]) : super(message, 'No internet');
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message]) : super(message, 'Request Time out');
}

class ServerException extends AppExceptions {
  ServerException([String? message]) : super(message, 'Internal server error');
}

class InvalidDataException  extends AppExceptions {
  InvalidDataException([String? message]) : super(message, 'Request Time out');
}

class UnknownException  extends AppExceptions {
  UnknownException ([String? message]) : super(message, 'Internal server error');
}

