import 'package:flutter/material.dart';
import 'package:flutter_bloc_arch/core/constants/strings.dart';
import 'package:flutter_bloc_arch/core/exceptions/route_exception.dart';
import 'package:flutter_bloc_arch/presentation/pages/home_page.dart';

class AppRouter {
  static const String home = '/';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => HomePage(
            title: Strings.HomePageTitle,
          ),
        );
      default:
        throw const RouteException('Route not found');
    }
  }
}
