import 'package:flutter/material.dart';

class AppRoutes {
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

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case home:
      //   return MaterialPageRoute(builder: (_) => const HomePage());
      // case login:
      //   return MaterialPageRoute(builder: (_) => const LoginPage());
      // case register:
      //   return MaterialPageRoute(builder: (_) => const RegisterPage());
      // case productList:
      //   final args = settings.arguments as Map<String, dynamic>?;
      //   return MaterialPageRoute(
      //     builder: (_) => ProductListPage(
      //       categoryId: args?['categoryId'],
      //       searchQuery: args?['searchQuery'],
      //     ),
      //   );
      // case productDetail:
      //   final product = settings.arguments;
      //   return MaterialPageRoute(
      //     builder: (_) => ProductDetailPage(product: product),
      //   );
      // case cart:
      //   return MaterialPageRoute(builder: (_) => const CartPage());
      // case checkout:
      //   return MaterialPageRoute(builder: (_) => const CheckoutPage());
      // case orderSuccess:
      //   final orderId = settings.arguments as String?;
      //   return MaterialPageRoute(
      //     builder: (_) => OrderSuccessPage(orderId: orderId),
      //   );
      // case profile:
      //   return MaterialPageRoute(builder: (_) => const ProfilePage());
      // case orders:
      //   return MaterialPageRoute(builder: (_) => const OrdersPage());
      // case orderDetail:
      //   return MaterialPageRoute(builder: (_) => const OrderDetailPage());
      // case categories:
      //   return MaterialPageRoute(builder: (_) => const CategoriesPage());
      // case search:
      //   return MaterialPageRoute(builder: (_) => const SearchPage());
      // case wishlist:
      //   return MaterialPageRoute(builder: (_) => const WishlistPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Route ${settings.name} not found')),
          ),
        );
    }
  }

  // Navigation helpers
  static void navigateTo(BuildContext context, String route, {Object? arguments}) {
    Navigator.pushNamed(context, route, arguments: arguments);
  }

  static void navigateToAndReplace(BuildContext context, String route, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, route, arguments: arguments);
  }

  static void navigateToAndRemoveUntil(BuildContext context, String route) {
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }
}
