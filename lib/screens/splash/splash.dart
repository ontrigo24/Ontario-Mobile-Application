import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Correct import for flutter_svg package
import 'package:ontrigo/utils/global_variables.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: GlobalVariables.colors.background, // Ensure GlobalVariables.colors.background is a valid property
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/icons/full_logo.svg'),
            SvgPicture.asset(
              'assets/icons/full_logo.svg', 
              semanticsLabel: 'Ontrigo Logo',
            ),
            Text('helo world')
          ],
        ),
      ),
    );
  }
}
