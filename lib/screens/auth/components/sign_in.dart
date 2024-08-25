import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ontrigo/screens/auth/components/forgot_password.dart';
import 'package:ontrigo/screens/auth/components/sign_up.dart';
import 'package:ontrigo/utils/global_variables.dart';
import 'package:ontrigo/utils/screen_size.dart';
import '../../../components/custom_onboarding_text_field.dart';
import '../../../components/primary_btn.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Future<void> Function() onSubmit;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _hidePassword = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: ScreenSizeConfig.screenHeight * 0.15),
            const Spacer(),
            Image.asset('assets/icons/full_logo.png'),
            const Column(
              children: [
                SizedBox(height: 8),
                Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Column(
              children: [
                CustomOnboardingTextField(
                  labelText: 'Email',
                  controller: widget.emailController,
                  sufixSvgIconPath: 'assets/icons/mail.svg',
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                const SizedBox(height: 4.0),
                CustomOnboardingTextField(
                  labelText: 'Password',
                  controller: widget.passwordController,
                  obscureText: _hidePassword,
                  sufixSvgIconPath: _hidePassword
                      ? 'assets/icons/Lock.svg'
                      : 'assets/icons/unlock.svg',
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  onTap: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenSizeConfig.screenWidth * 0.08),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Don’t Have an Account? ",
                            style: TextStyle(
                                fontSize:
                                    ScreenSizeConfig.screenHeight * 0.013),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const SignUpScreen()));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: ScreenSizeConfig.screenHeight * 0.013,
                                color: GlobalVariables.colors.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: ScreenSizeConfig.screenWidth * 0.045),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const ForgotPassword()));
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontSize: ScreenSizeConfig.screenHeight * 0.013),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            PrimaryButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        await widget.onSubmit();
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
              title: _isLoading ? 'Loading...' : 'Sign In',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: ScreenSizeConfig.screenWidth * 0.08,
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 0.5,
                      color: const Color(0xFFA2A2A2),
                    )),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      'OR',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: ScreenSizeConfig.screenWidth * 0.08,
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 0.5,
                      color: const Color(0xFFA2A2A2),
                    )),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/FB_icon.svg'),
                const SizedBox(width: 10),
                SvgPicture.asset('assets/icons/Google_icon.svg'),
              ],
            ),
            SizedBox(height: ScreenSizeConfig.screenHeight * 0.05),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Copyright 2024 All Rights Reserved',
                style: TextStyle(
                  fontSize: ScreenSizeConfig.screenHeight * 0.013,
                  color: const Color(0xFF545454),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
