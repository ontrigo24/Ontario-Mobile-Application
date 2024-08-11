// Centralized route generator
import 'package:flutter/material.dart';
import 'package:ontrigo/screens/home/home.dart';
import 'package:ontrigo/screens/splash/splash.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (_) => const SplashScreen(),
  HomeScreen.routeName: (_) => const HomeScreen(),
};

Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    default: 
      if (routes.containsKey(routeSettings.name)) {
        return MaterialPageRoute(builder: routes[routeSettings.name]!);
      }
      return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
}
