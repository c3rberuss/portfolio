class ApiException implements Exception {
  final String message;

  ApiException([this.message]);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException([String message]) : super(message);
}

class ForbiddenException extends ApiException {
  ForbiddenException([String message]) : super(message);
}

class NotFoundException extends ApiException {
  NotFoundException([String message]) : super(message);
}

class WithoutInternetException extends ApiException {
  WithoutInternetException([String message]) : super(message);
}
