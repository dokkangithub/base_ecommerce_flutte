// lib/config/app_config.dart

enum Environment { development, staging, production }

class AppConfig {
  String apiBaseUrl;
  Environment environment;
  bool enableLogging;
  String appName;
  String appVersion;
  String? wordpressUrl;
  String? laravelUrl;
  int connectTimeout;
  int receiveTimeout;

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
    this.environment = environment;
    this.apiBaseUrl = apiBaseUrl;
    this.wordpressUrl = wordpressUrl ?? this.wordpressUrl;
    this.laravelUrl = laravelUrl ?? this.laravelUrl;
    this.enableLogging = enableLogging ?? this.enableLogging;
    this.appName = appName ?? this.appName;
    this.appVersion = appVersion ?? this.appVersion;
    this.connectTimeout = connectTimeout ?? this.connectTimeout;
    this.receiveTimeout = receiveTimeout ?? this.receiveTimeout;
  }

  // Helper method to check if we're in production
  bool get isProduction => environment == Environment.production;

  // Helper method to check if we're in development
  bool get isDevelopment => environment == Environment.development;
}