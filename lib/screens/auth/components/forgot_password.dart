// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ontrigo/API/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_onboarding_text_field.dart';
import '../../../components/primary_btn.dart';
import '../../../utils/screen_size.dart';

enum SetMode { emailVerification, setNewPassword }

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // Form key to manage form state
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isEnable = false;
  bool _hideCode = true;
  bool _isLoading = false;
  SetMode _setMode = SetMode.emailVerification;

  void handleSubmitBtn() {
    if (_formKey.currentState?.validate() ?? false) {
      final user = Provider.of<UserProvider>(context, listen: false);
      final payload = {
        "password": newPasswordController.text.trim(),
        "confirmPassword": confirmPasswordController.text.trim(),
        "email": emailController.text.toLowerCase(),
        "otp": codeController.text
      };

      setState(() {
        _isLoading = true;
      });
      if (!_isEnable) {
        _sendOtpRequest();
      } else if (_setMode != SetMode.setNewPassword) {
        setState(() {
          _setMode = SetMode.setNewPassword;
          _isLoading = false;
        });
      } else {
        user.forgotPassword(context, payload).then((res) {
          print(res['statusCode']);
          if (res['statusCode'] == 200) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Reseting password failed!')),
            );
          }
        }).catchError((error) {
          debugPrint('Resetting password failed: $error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Reseting password failed: $error')),
          );
        }).whenComplete(() {
          // Reset loading state
          setState(() {
            _isLoading = false;
          });
        });
      }
    }
  }

  // Function to send OTP request
  Future<void> _sendOtpRequest() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    final payload = {
      "email": emailController.text.toLowerCase(),
      "type": "forgotPassword"
    };

    try {
      await user.sendOtp(payload);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP sent successfully!')),
      );
      setState(() {
        _isEnable = true;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send OTP: $error')),
      );
    } finally {
      // Reset the loading state
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    emailController.dispose();
    codeController.dispose();
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

  // Confirm Password validator method
  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    }
    return value != newPasswordController.text
        ? 'Password Does not Match'
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: ScreenSizeConfig.screenHeight * 0.085),
              const Spacer(),
              Column(
                children: [
                  Image.asset('assets/icons/full_logo.png'),
                  SizedBox(height: ScreenSizeConfig.screenHeight * 0.015),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              _setMode == SetMode.emailVerification
                  ? Column(
                      children: [
                        SizedBox(height: ScreenSizeConfig.screenHeight * 0.055),
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
                          validator: emailValidator,
                        ),
                        const SizedBox(
                            height: 4.0), // Space between text fields
                        CustomOnboardingTextField(
                          labelText: 'Enter Code',
                          controller: codeController,
                          obscureText: _hideCode,
                          isEnabled: _isEnable,
                          sufixSvgIconPath: _hideCode
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
                              _hideCode = !_hideCode;
                            });
                          },
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(height: ScreenSizeConfig.screenHeight * 0.055),
                        CustomOnboardingTextField(
                          labelText: 'New Password',
                          controller: newPasswordController,
                          obscureText: _hideCode,
                          isEnabled: _isEnable,
                          sufixSvgIconPath: _hideCode
                              ? 'assets/icons/Lock.svg'
                              : 'assets/icons/unlock.svg',
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          onTap: () {
                            setState(() {
                              _hideCode = !_hideCode;
                            });
                          },
                          validator: passwordValidator,
                        ),
                        const SizedBox(
                            height: 4.0), // Space between text fields
                        CustomOnboardingTextField(
                          labelText: 'Confirm Password',
                          controller: confirmPasswordController,
                          obscureText: _hideCode,
                          isEnabled: _isEnable,
                          sufixSvgIconPath: _hideCode
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
                              _hideCode = !_hideCode;
                            });
                          },
                          validator: confirmPasswordValidator,
                        ),
                      ],
                    ),
              const SizedBox(height: 16.0),
              SizedBox(height: ScreenSizeConfig.screenHeight * 0.015),
              PrimaryButton(
                  onPressed: _isLoading ? null : handleSubmitBtn,
                  title: _isLoading
                      ? 'Loading..'
                      : _isEnable
                          ? 'Next'
                          : 'Send Code'),
              SizedBox(height: ScreenSizeConfig.screenHeight * 0.085),
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
      ),
    );
  }
}
