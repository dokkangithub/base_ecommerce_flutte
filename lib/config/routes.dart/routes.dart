// lib/config/routes.dart

import 'package:flutter/material.dart';

// Import your pages

class AppRoutes {
  // Route names as constants
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String productList = '/products';
  static const String productDetail = '/product/detail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orderSuccess = '/order/success';
  static const String profile = '/profile';
  static const String orders = '/orders';
  static const String orderDetail = '/order/detail';
  static const String categories = '/categories';
  static const String search = '/search';
  static const String wishlist = '/wishlist';

  // Route generator function
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case splash:
      //   return MaterialPageRoute(
      //     builder: (_) => const HomePage(),
      //   );
      // case login:
      //   return MaterialPageRoute(
      //     builder: (_) => const LoginPage(),
      //   );
      // case register:
      //   return MaterialPageRoute(
      //     builder: (_) => const RegisterPage(),
      //   );
      // case home:
      //   return MaterialPageRoute(
      //     builder: (_) => const HomePage(),
      //   );
      // case productList:
      //   final Map<String, dynamic>? args = settings.arguments as Map<String, dynamic>?;
      //   final String? categoryId = args?['categoryId'] as String?;
      //   final String? searchQuery = args?['searchQuery'] as String?;
      //
      //   return MaterialPageRoute(
      //     builder: (_) => ProductListPage(
      //       categoryId: categoryId,
      //       searchQuery: searchQuery,
      //     ),
      //   );
      // case productDetail:
      //   final Product product = settings.arguments as Product;
      //   return MaterialPageRoute(
      //     builder: (_) => ProductDetailPage(product: product),
      //   );
      // case cart:
      //   return MaterialPageRoute(
      //     builder: (_) => const CartPage(),
      //   );
      // case checkout:
      //   return MaterialPageRoute(
      //     builder: (_) => const CheckoutPage(),
      //   );
      // case orderSuccess:
      //   final String? orderId = settings.arguments as String?;
      //   return MaterialPageRoute(
      //     builder: (_) => OrderSuccessPage(orderId: orderId),
      //   );
    // Add more routes as needed
      default:
      // If there is no such named route, return an error page
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Route ${settings.name} not found'),
            ),
          ),
        );
    }
  }

  // Navigation helpers
  static void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, login);
  }

  static void navigateToRegister(BuildContext context) {
    Navigator.pushNamed(context, register);
  }

  static void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, home, (route) => false);
  }

  // static void navigateToProductDetail(BuildContext context, Product product) {
  //   Navigator.pushNamed(
  //     context,
  //     productDetail,
  //     arguments: product,
  //   );
  // }

  static void navigateToProductList(BuildContext context, {String? categoryId, String? searchQuery}) {
    Navigator.pushNamed(
      context,
      productList,
      arguments: {
        'categoryId': categoryId,
        'searchQuery': searchQuery,
      },
    );
  }

  static void navigateToCart(BuildContext context) {
    Navigator.pushNamed(context, cart);
  }

  static void navigateToCheckout(BuildContext context) {
    Navigator.pushNamed(context, checkout);
  }

  static void navigateToOrderSuccess(BuildContext context, String orderId) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      orderSuccess,
          (route) => false,
      arguments: orderId,
    );
  }
}