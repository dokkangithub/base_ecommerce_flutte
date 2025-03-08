// lib/config/app_config.dart

enum Environment { development, staging, production }

class AppConfig {
  final String apiBaseUrl;
  final Environment environment;
  final bool enableLogging;
  final String appName;
  final String appVersion;
  final String? wordpressUrl;
  final String? laravelUrl;
  final int connectTimeout;
  final int receiveTimeout;

  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal({
    this.apiBaseUrl = 'https://api.example.com',
    this.environment = Environment.development,
    this.enableLogging = true,
    this.appName = 'E-Commerce App',
    this.appVersion = '1.0.0',
    this.wordpressUrl = 'https://wordpress.example.com/wp-json/wc/v3',
    this.laravelUrl = 'https://laravel.example.com/api',
    this.connectTimeout = 30000,
    this.receiveTimeout = 30000,
  });

  // Initialize with environment-specific values
  void initialize({
    required Environment environment,
    required String apiBaseUrl,
    String? wordpressUrl,
    String? laravelUrl,
    bool? enableLogging,
    String? appName,
    String? appVersion,
    int? connectTimeout,
    int? receiveTimeout,
  }) {
    _instance
      ..environment = environment
      ..apiBaseUrl = apiBaseUrl
      ..wordpressUrl = wordpressUrl ?? this.wordpressUrl
      ..laravelUrl = laravelUrl ?? this.laravelUrl
      ..enableLogging = enableLogging ?? this.enableLogging
      ..appName = appName ?? this.appName
      ..appVersion = appVersion ?? this.appVersion
      ..connectTimeout = connectTimeout ?? this.connectTimeout
      ..receiveTimeout = receiveTimeout ?? this.receiveTimeout;
  }

  // Allow modification of values for testing
  set environment(Environment value) => _instance.environment = value;
  set apiBaseUrl(String value) => _instance.apiBaseUrl = value;
  set wordpressUrl(String? value) => _instance.wordpressUrl = value;
  set laravelUrl(String? value) => _instance.laravelUrl = value;
  set enableLogging(bool value) => _instance.enableLogging = value;
  set appName(String value) => _instance.appName = value;
  set appVersion(String value) => _instance.appVersion = value;
  set connectTimeout(int value) => _instance.connectTimeout = value;
  set receiveTimeout(int value) => _instance.receiveTimeout = value;

  // Helper method to check if we're in production
  bool get isProduction => environment == Environment.production;

  // Helper method to check if we're in development
  bool get isDevelopment => environment == Environment.development;
}