// lib/core/api/api_provider.dart

import 'package:dio/dio.dart';

/// Abstract class that defines the contract for API providers
abstract class ApiProvider {
  /// Base URL for API endpoints
  String get baseUrl;

  /// Performs a GET request to the specified endpoint
  Future<dynamic> get(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      });

  /// Performs a POST request to the specified endpoint
  Future<dynamic> post(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      });

  /// Performs a PUT request to the specified endpoint
  Future<dynamic> put(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      });

  /// Performs a DELETE request to the specified endpoint
  Future<dynamic> delete(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      });

  /// Sets the auth token for authenticated requests
  void setAuthToken(String token);

  /// Sets the language for API requests
  void setLanguage(String languageCode);
}