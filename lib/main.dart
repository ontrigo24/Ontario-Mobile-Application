import 'package:flutter/material.dart';
import 'package:ontrigo/routes/routes.dart';
import 'package:ontrigo/screens/home/home.dart';
import 'package:ontrigo/screens/splash/splash.dart';
import 'package:ontrigo/utils/global_variables.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OntriGo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: GlobalVariables.colors.primary),
        useMaterial3: true,
      ),
      onGenerateRoute: (routeSettings) => onGenerateRoute(routeSettings),
      initialRoute: SplashScreen.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}

