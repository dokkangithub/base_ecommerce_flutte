import 'dart:io';
import 'package:dio/dio.dart';
import '../../config/app_config.dart/app_config.dart';
import '../errors/exceptions.dart';
import '../utils/logger.dart';
import 'api_provider.dart';

class LaravelApiProvider implements ApiProvider {
  late final Dio _dio;
  final AppConfig _appConfig = AppConfig();
  String _languageCode = 'en';

  LaravelApiProvider() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _appConfig.laravelUrl ?? '',
        connectTimeout: Duration(milliseconds: _appConfig.connectTimeout),
        receiveTimeout: Duration(milliseconds: _appConfig.receiveTimeout),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Add logging interceptor in development mode
    if (_appConfig.enableLogging) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (object) => Logger.d('DIO', object.toString()),
        ),
      );
    }

    // Add language interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Accept-Language'] = _languageCode;
          return handler.next(options);
        },
      ),
    );
  }

  @override
  String get baseUrl => _appConfig.laravelUrl ?? '';

  @override
  Future<dynamic> get(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    } on SocketException {
      throw const NetworkException('No internet connection');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<dynamic> post(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    } on SocketException {
      throw const NetworkException('No internet connection');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<dynamic> put(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    } on SocketException {
      throw const NetworkException('No internet connection');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<dynamic> delete(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    } on SocketException {
      throw const NetworkException('No internet connection');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  void setLanguage(String languageCode) {
    _languageCode = languageCode;
  }

  /// Handles Dio errors and throws appropriate custom exceptions
  void _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const TimeoutException('Request timeout');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;

        if (statusCode == 401) {
          throw const UnauthorizedException('Unauthorized');
        } else if (statusCode == 403) {
          throw const ForbiddenException('Forbidden');
        } else if (statusCode == 404) {
          throw const NotFoundException('Resource not found');
        } else if (statusCode == 422) {
          // Handle validation errors
          final errors = responseData is Map ? responseData['errors'] : null;
          throw ValidationException(
            'Validation error',
            errors: errors is Map ? Map<String, dynamic>.from(errors) : null,
          );
        } else {
          final message = responseData is Map ?
          responseData['message'] ?? 'Server error' :
          'Server error';
          throw ServerException(message);
        }
      case DioExceptionType.cancel:
        throw const RequestCancelledException('Request cancelled');
      case DioExceptionType.unknown:
        if (e.error is SocketException) {
          throw const NetworkException('No internet connection');
        }
        throw ServerException(e.message ?? 'Unknown error');
      default:
        throw ServerException(e.message ?? 'Server error');
    }
  }
}