import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ontrigo/utils/global_variables.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loading = true;
  void checkAuth() async {
    Timer(
      const Duration(seconds: 3),
      () async {
        setState(() {
          loading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    checkAuth();
    return Scaffold(
      backgroundColor: GlobalVariables.colors.background,
      body: loading
          ? Center(
              child: Image.asset('assets/icons/full_logo.png'),
            )
          : Container(),
    );
  }
}
