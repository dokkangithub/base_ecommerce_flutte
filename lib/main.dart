import 'package:flutter/material.dart';
import 'config/app_config.dart/app_config.dart';
import 'config/routes.dart/routes.dart';
import 'config/themes.dart/theme.dart';
import 'core/di/injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();

  AppConfig().initialize(
    environment: Environment.development,
    apiBaseUrl: 'https://dev-api.example.com',
    wordpressUrl: 'https://dev-wordpress.example.com/wp-json/wc/v3',
    laravelUrl: 'https://dev-laravel.example.com/api',
    enableLogging: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig().appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.splash,
    );
  }
}
