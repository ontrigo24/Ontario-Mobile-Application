import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/primary_btn.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/screen_size.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _selectedOption = 'Email & Password';

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
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text('Please select one option'),
              ],
            ),
            // Radio buttons for selecting sign up option
            Column(
              children: [
                CustomOnboardingRadioBtn(
                  title: 'Facebook',
                  value: 'Facebook',
                  groupValue: _selectedOption,
                  onChange: (String? value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                  leadingSvgPath: 'assets/icons/F.svg',
                ),
                CustomOnboardingRadioBtn(
                  title: 'Goolge',
                  value: 'Google',
                  groupValue: _selectedOption,
                  onChange: (String? value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                  leadingSvgPath: 'assets/icons/G.svg',
                ),
                CustomOnboardingRadioBtn(
                  title: 'Email & Password',
                  value: 'Email & Password',
                  groupValue: _selectedOption,
                  onChange: (String? value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                  leadingSvgPath: 'assets/icons/mail.svg',
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            PrimaryButton(
              onPressed: () {
                // Handle the "Next" button action based on the selected option
                print('Selected Sign Up Option: $_selectedOption');
              },
              title: 'Next',
            ),
            SizedBox(height: ScreenSizeConfig.screenHeight * 0.075),
          ],
        ),
      ),
    );
  }
}

class CustomOnboardingRadioBtn extends StatelessWidget {
  const CustomOnboardingRadioBtn({
    super.key,
    required this.onChange,
    required this.groupValue,
    required this.title,
    required this.value,
    required this.leadingSvgPath,
  });

  final ValueChanged<String?>? onChange;
  final String title;
  final String value;
  final String groupValue;
  final String leadingSvgPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSizeConfig.screenHeight * 0.12,
      margin: EdgeInsets.symmetric(horizontal: ScreenSizeConfig.screenWidth * 0.04, vertical: ScreenSizeConfig.screenWidth * 0.012),
      padding: EdgeInsets.all(ScreenSizeConfig.screenWidth * 0.04),
      decoration: groupValue == value
          ? BoxDecoration(
              color: GlobalVariables.colors.secondary.withOpacity(0.15),
              border: Border.all(color: GlobalVariables.colors.secondary),
              borderRadius: BorderRadius.all(
                Radius.circular(ScreenSizeConfig.screenHeight * 0.2),
              ),
            )
          : BoxDecoration(
              color: const Color.fromARGB(255, 240, 240, 240),
              borderRadius: BorderRadius.all(
                Radius.circular(ScreenSizeConfig.screenHeight * 0.2),
              ),
            ),
      child: Align(
        alignment: Alignment.center,
        child: ListTile(
          title: Text(
            title,
            style: groupValue == value
                ? TextStyle(
                    color: GlobalVariables.colors.secondary,
                    fontWeight: FontWeight.bold)
                : const TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: Container(
              padding: EdgeInsets.all(ScreenSizeConfig.screenHeight * 0.02),
              width: ScreenSizeConfig.screenWidth * 0.14,
              decoration: BoxDecoration(
                  color: groupValue == value
                      ? GlobalVariables.colors.secondary
                      : const Color(0xFFF0F0F0),
                  borderRadius:
                      BorderRadius.circular(ScreenSizeConfig.screenHeight)),
              child: SvgPicture.asset(
                leadingSvgPath,
                color: groupValue == value
                    ? GlobalVariables.colors.textAltPrimary
                    : GlobalVariables.colors.textPrimary,
              )),
          trailing: Radio<String>(
              activeColor: GlobalVariables.colors.secondary,
              value: value,
              groupValue: groupValue,
              onChanged: onChange),
        ),
      ),
    );
  }
}
