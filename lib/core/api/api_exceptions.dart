// lib/core/api/api_exceptions.dart

/// Base exception class for all API exceptions
class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}

/// Exception thrown when there's a network connectivity issue
class NetworkException extends ApiException {
  NetworkException(String message) : super(message);
}

/// Exception thrown when the API response couldn't be parsed
class ParseException extends ApiException {
  ParseException(String message) : super(message);
}

/// Exception thrown for 401 Unauthorized responses
class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super(message);
}

/// Exception thrown for 403 Forbidden responses
class ForbiddenException extends ApiException {
  ForbiddenException(String message) : super(message);
}

/// Exception thrown for 404 Not Found responses
class NotFoundException extends ApiException {
  NotFoundException(String message) : super(message);
}

/// Exception thrown for 500+ Server Error responses
class ServerException extends ApiException {
  ServerException(String message) : super(message);
}