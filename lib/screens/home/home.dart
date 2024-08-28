import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ontrigo/API/models/user_data.dart';
import 'package:ontrigo/API/providers/user_provider.dart';
import 'package:ontrigo/utils/screen_size.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    UserData? user = Provider.of<UserProvider>(context).userData;
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/under-construction-board.json'),
              const SizedBox(height: 20),  // Added for spacing between Lottie animation and text
              SizedBox(
                height: ScreenSizeConfig.screenHeight * 0.2,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Hi, ${user?.data?.firstName}\n'
                      'Welcome to the Home Screen,\n\n'
                      'You successfully logged into the application. Thank you for testing.\n\n'
                      'Srijan is developming the application and will be completed very soon.',
                      textStyle: const TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                      ),
                      speed: const Duration(milliseconds: 50),
                    ),
                  ],
                  totalRepeatCount: 1,  // Set to 1 to animate only once
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,  // Show full text if tapped
                  stopPauseOnTap: true,  // Stop animation if tapped
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
