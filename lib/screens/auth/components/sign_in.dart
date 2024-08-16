import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ontrigo/screens/auth/components/sign_up.dart';
import 'package:ontrigo/utils/global_variables.dart';
import 'package:ontrigo/utils/screen_size.dart';

import '../../../components/primary_btn.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: ScreenSizeConfig.screenHeight * 0.15),
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
                  'Sign In',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text('Please fill your credentials'),
              ],
            ),
            const SizedBox(height: 16.0),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: GlobalVariables.colors.inputFieldEnabledBorder,
                          width: 1.0),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)),
                    ),
                    child: Align(
                      alignment: const Alignment(0, 0.2),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              'assets/icons/mail.svg',
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4.0), // Space between text fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: GlobalVariables.colors.inputFieldEnabledBorder,
                          width: 1.0),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                    ),
                    child: Align(
                      alignment: const Alignment(2, 0.2),
                      child: TextFormField(
                        obscureText: true, // To hide the password input
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              'assets/icons/Lock.svg',
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                    height: 16.0), // Space between text fields and RichText
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenSizeConfig.screenWidth * 0.095),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Don’t Have an Account? ",
                            style: TextStyle(
                                fontSize:
                                    ScreenSizeConfig.screenHeight * 0.015),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (_) => const SignUpScreen()));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: ScreenSizeConfig.screenHeight * 0.015,
                                color: GlobalVariables.colors.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle SignUp tap
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontSize: ScreenSizeConfig.screenHeight * 0.015),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            PrimaryButton(onPressed: () {}, title: 'Sign In'),
            Row(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/FB_icon.svg'),
                const SizedBox(width: 10),
                SvgPicture.asset('assets/icons/Google_icon.svg'),
              ],
            ),
            SizedBox(height: ScreenSizeConfig.screenHeight * 0.075),
          ],
        ),
      ),
    );
  }
}
