import 'package:flutter/material.dart';

import '../../../components/custom_onboarding_text_field.dart';
import '../../../components/primary_btn.dart';
import '../../../utils/screen_size.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8), // Added space between the texts
                Text(
                  'Sign Up',
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
                  labelText: 'Password',
                  controller: null,
                  obscureText: true,
                  sufixSvgIconPath: 'assets/icons/Lock.svg',
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                SizedBox(height: 4.0), // Space between text fields
                CustomOnboardingTextField(
                  labelText: 'First Name',
                  controller: null,
                  sufixSvgIconPath: 'assets/icons/user.svg',
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                SizedBox(height: 4.0), // Space between text fields
                CustomOnboardingTextField(
                  labelText: 'Last Name',
                  controller: null,
                  sufixSvgIconPath: 'assets/icons/user.svg',
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
            PrimaryButton(onPressed: () {}, title: 'Done'),
            SizedBox(height: ScreenSizeConfig.screenHeight * 0.085),
          ],
        ),
      ),
    );
  }
}
