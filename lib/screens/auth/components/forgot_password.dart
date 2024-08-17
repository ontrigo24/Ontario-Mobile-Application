import 'package:flutter/material.dart';

import '../../../components/custom_onboarding_text_field.dart';
import '../../../components/primary_btn.dart';
import '../../../utils/screen_size.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: ScreenSizeConfig.screenHeight * 0.085),
            Image.asset('assets/icons/full_logo.png'),
            const Column(
              children: [
                Text(
                  'Forgot Password!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8), // Added space between the texts
                Text(
                  'Let’s get back',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text('Please fill your informations'),
              ],
            ),
            const Column(
              children: [
                CustomOnboardingTextField(
                  labelText: 'Email',
                  controller: null,
                  sufixSvgIconPath: 'assets/icons/mail.svg',
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                SizedBox(height: 4.0), // Space between text fields
                CustomOnboardingTextField(
                  labelText: 'Enter Code',
                  controller: null,
                  obscureText: true,
                  isEnabled: false,
                  sufixSvgIconPath: 'assets/icons/Lock.svg',
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            PrimaryButton(onPressed: () {}, title: 'Send Code'),
            SizedBox(height: ScreenSizeConfig.screenHeight * 0.085),
          ],
        ),
      ),
    );
  }
}