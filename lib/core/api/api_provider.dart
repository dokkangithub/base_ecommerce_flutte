// lib/core/api/api_provider.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Abstract API Provider interface
/// This follows the Interface Segregation Principle (from SOLID)
/// by defining a contract for all API providers to implement
abstract class ApiProvider {
  /// Performs a GET request to the specified endpoint
  Future<Map<String, dynamic>> get(String endpoint, {Map<String, String>? headers});

  /// Performs a POST request to the specified endpoint
  Future<Map<String, dynamic>> post(String endpoint, {Map<String, dynamic>? body, Map<String, String>? headers});

  /// Performs a PUT request to the specified endpoint
  Future<Map<String, dynamic>> put(String endpoint, {Map<String, dynamic>? body, Map<String, String>? headers});

  /// Performs a DELETE request to the specified endpoint
  Future<Map<String, dynamic>> delete(String endpoint, {Map<String, String>? headers});

  /// Uploads a file to the specified endpoint
  Future<Map<String, dynamic>> uploadFile(String endpoint, File file, {Map<String, String>? fields, Map<String, String>? headers});
}

/// Base implementation of ApiProvider with common functionality
/// This follows the Single Responsibility Principle by handling only HTTP communications
class BaseApiProvider implements ApiProvider {
  final String baseUrl;
  final http.Client client;
  final Duration timeout;

  BaseApiProvider({
    required this.baseUrl,
    required this.client,
    this.timeout = const Duration(seconds: 30),
  });

  /// Handles the HTTP response and throws appropriate exceptions
  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return json.decode(response.body) as Map<String, dynamic>;
      } catch (e) {
        throw ParseException('Failed to parse response: ${response.body}');
      }
    } else if (response.statusCode == 401) {
      throw UnauthorizedException('Unauthorized: ${response.body}');
    } else if (response.statusCode == 403) {
      throw ForbiddenException('Forbidden: ${response.body}');
    } else if (response.statusCode == 404) {
      throw NotFoundException('Not found: ${response.body}');
    } else if (response.statusCode >= 500) {
      throw ServerException('Server error: ${response.body}');
    } else {
      throw ApiException('API error: ${response.statusCode} - ${response.body}');
    }
  }

  /// Combines the base URL with the endpoint
  String _getUrl(String endpoint) {
    return endpoint.startsWith('http') ? endpoint : '$baseUrl$endpoint';
  }

  /// Gets default headers for all requests
  Map<String, String> _getDefaultHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  /// Combines default headers with custom headers
  Map<String, String> _combineHeaders(Map<String, String>? customHeaders) {
    final defaultHeaders = _getDefaultHeaders();
    return customHeaders == null
        ? defaultHeaders
        : {...defaultHeaders, ...customHeaders};
  }

  @override
  Future<Map<String, dynamic>> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await client
          .get(
        Uri.parse(_getUrl(endpoint)),
        headers: _combineHeaders(headers),
      )
          .timeout(timeout);
      return _handleResponse(response);
    } on SocketException {
      throw NetworkException('No internet connection');
    } on TimeoutException {
      throw TimeoutException('Request timed out');
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException('Unknown error: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> post(
      String endpoint,
      {Map<String, dynamic>? body, Map<String, String>? headers}
      ) async {
    try {
      final response = await client
          .post(
        Uri.parse(_getUrl(endpoint)),
        body: body != null ? json.encode(body) : null,
        headers: _combineHeaders(headers),
      )
          .timeout(timeout);
      return _handleResponse(response);
    } on SocketException {
      throw NetworkException('No internet connection');
    } on TimeoutException {
      throw TimeoutException('Request timed out');
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException('Unknown error: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> put(
      String endpoint,
      {Map<String, dynamic>? body, Map<String, String>? headers}
      ) async {
    try {
      final response = await client
          .put(
        Uri.parse(_getUrl(endpoint)),
        body: body != null ? json.encode(body) : null,
        headers: _combineHeaders(headers),
      )
          .timeout(timeout);
      return _handleResponse(response);
    } on SocketException {
      throw NetworkException('No internet connection');
    } on TimeoutException {
      throw TimeoutException('Request timed out');
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException('Unknown error: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> delete(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await client
          .delete(
        Uri.parse(_getUrl(endpoint)),
        headers: _combineHeaders(headers),
      )
          .timeout(timeout);
      return _handleResponse(response);
    } on SocketException {
      throw NetworkException('No internet connection');
    } on TimeoutException {
      throw TimeoutException('Request timed out');
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException('Unknown error: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> uploadFile(
      String endpoint,
      File file,
      {Map<String, String>? fields, Map<String, String>? headers}
      ) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(_getUrl(endpoint)));

      // Add fields if provided
      if (fields != null) {
        request.fields.addAll(fields);
      }

      // Add file
      final fileName = file.path.split('/').last;
      final fileStream = http.ByteStream(file.openRead());
      final fileLength = await file.length();

      final multipartFile = http.MultipartFile(
        'file',
        fileStream,
        fileLength,
        filename: fileName,
      );

      request.files.add(multipartFile);

      // Add headers
      request.headers.addAll(_combineHeaders(headers));

      // Send request
      final streamedResponse = await request.send().timeout(timeout);
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException('No internet connection');
    } on TimeoutException {
      throw TimeoutException('Request timed out');
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException('Unknown error: $e');
    }
  }
}