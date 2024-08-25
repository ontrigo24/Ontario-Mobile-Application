// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../API/providers/user_provider.dart';
import '../../../components/custom_onboarding_text_field.dart';
import '../../../components/custom_otp_field.dart';
import '../../../components/primary_btn.dart';
import '../../../utils/screen_size.dart';
import '../../home/home.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // Controllers for each text field
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  // Form key to manage form state
  final _formKey = GlobalKey<FormState>();

  // Loading state for button
  bool isLoading = false;

  bool _hidePassword = true;

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    otpController.dispose();
    super.dispose();
  }

  // Email validator method
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Regular expression for email validation
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null; // Return null if the email is valid
  }

  // Password validator method
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter.';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter.';
    }

    // Check for at least one digit
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain at least one digit.';
    }

    // Check for at least one special character
    if (!RegExp(r'[@$!%*?&]').hasMatch(value)) {
      return 'Password must contain at least one special character.';
    }
    // Regular expression for password validation
    final RegExp passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

    if (!passwordRegex.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, '
          '\none lowercase letter, one digit, and one special character.';
    }

    return null; // Return null if the password is valid
  }

  // First name validator method
  String? firstNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'First name is required';
    }
    return null; // Return null if the first name is valid
  }

  // Last name validator method
  String? lastNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last name is required';
    }
    return null; // Return null if the last name is valid
  }

  // Function to show the OTP dialog
  void _showOtpDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Prevents dismissing the dialog by tapping outside if made false
      builder: (BuildContext context) {
        String otp = ''; // Variable to store the entered OTP
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(50.0), // Set the rounded border here
          ),
          content: SingleChildScrollView(
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              height: ScreenSizeConfig.screenHeight * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 242, 242, 242),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            icon: const Icon(Icons.close, size: 18.0),
                          ))
                    ],
                  ),
                  const Text(
                    'Verify email',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
                  Text(
                    'Please enter the 4 digit code sent to ${emailController.text}.',
                    style: const TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                  CustomOtpField(
                    onChanged: (value) {
                      otp = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            PrimaryButton(
                width: ScreenSizeConfig.screenWidth * 0.6,
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  otpController.text = otp; // Assign the OTP to the controller
                  handleSubmitBtn(); // Calling submit function to verify OTP
                },
                title: 'Verify')
          ],
        );
      },
    );
  }

  // Function to show success dialog
  void _showSuccessDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Prevents dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(50.0), // Set the rounded border here
          ),
          content: SingleChildScrollView(
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              height: ScreenSizeConfig.screenHeight * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 242, 242, 242),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()),
                                (route) => false, // Remove all previous routes
                              );
                            },
                            icon: const Icon(Icons.close, size: 18.0),
                          ))
                    ],
                  ),
                  SvgPicture.asset('assets/icons/success-check.svg'),
                  const Text(
                    'Successful',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
                  const Text(
                    'Yahoo! You have successfully verified the account.',
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            PrimaryButton(
                width: ScreenSizeConfig.screenWidth * 0.6,
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false, // Remove all previous routes
                  );
                },
                title: 'done')
          ],
        );
      },
    );
  }

  // Function to send OTP request
  Future<void> _sendOtpRequest() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    final payload = {"email": emailController.text, "type": "signup"};

    try {
      await user.sendOtp(payload);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP sent successfully!')),
      );
      // Show OTP dialog only if OTP sent successfully
      _showOtpDialog(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send OTP: $error')),
      );
    } finally {
      // Reset the loading state
      setState(() {
        isLoading = false;
      });
    }
  }

  void handleSubmitBtn() {
    if (_formKey.currentState?.validate() ?? false) {
      final user = Provider.of<UserProvider>(context, listen: false);
      final payload = {
        "email": emailController.text,
        "otp": otpController.text.isEmpty ? null : otpController.text,
        "password": passwordController.text,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
      };

      setState(() {
        isLoading = true;
      });

      if (payload["otp"] == null) {
        // OTP is null, send OTP request
        _sendOtpRequest();
      } else {
        // Proceed with signup if OTP is already provided
        user.signUp(context, payload).then((_) {
          if (user.userData?.statusCode == 200) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Show success dialog on sign-up success
              _showSuccessDialog(context);
            });
          } else {
            // Handle sign-up failure if necessary
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sign-up failed!')),
            );
          }
        }).catchError((error) {
          // Handle any errors that occur during sign-up
          debugPrint('Sign-up failed: $error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sign-up failed: $error')),
          );
        }).whenComplete(() {
          // Reset loading state
          setState(() {
            isLoading = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
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
              Column(
                children: [
                  CustomOnboardingTextField(
                    labelText: 'Email',
                    controller: emailController,
                    sufixSvgIconPath: 'assets/icons/mail.svg',
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    // Use the emailValidator method
                    validator: emailValidator,
                  ),
                  const SizedBox(height: 4.0), // Space between text fields
                  CustomOnboardingTextField(
                    labelText: 'Password',
                    controller: passwordController,
                    obscureText: _hidePassword,
                    sufixSvgIconPath: _hidePassword
                        ? 'assets/icons/Lock.svg'
                        : 'assets/icons/unlock.svg',
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    // Use the passwordValidator method
                    validator: passwordValidator,
                    onTap: () {
                      setState(() {
                        _hidePassword = !_hidePassword;
                      });
                    },
                  ),
                  const SizedBox(height: 4.0), // Space between text fields
                  CustomOnboardingTextField(
                    labelText: 'First Name',
                    controller: firstNameController,
                    sufixSvgIconPath: 'assets/icons/user.svg',
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    // Use the firstNameValidator method
                    validator: firstNameValidator,
                  ),
                  const SizedBox(height: 4.0), // Space between text fields
                  CustomOnboardingTextField(
                    labelText: 'Last Name',
                    controller: lastNameController,
                    sufixSvgIconPath: 'assets/icons/user.svg',
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    // Use the lastNameValidator method
                    validator: lastNameValidator,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              PrimaryButton(
                onPressed: isLoading ? null : handleSubmitBtn,
                title: isLoading ? 'Loading...' : 'Done',
              ),
              SizedBox(height: ScreenSizeConfig.screenHeight * 0.085),
            ],
          ),
        ),
      ),
    );
  }
}
