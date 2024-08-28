import 'package:flutter/material.dart';
import 'package:ontrigo/API/providers/user_provider.dart';
import 'package:ontrigo/screens/auth/components/sign_in.dart';
import 'package:ontrigo/screens/home/home.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> handleOnSubmit() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    final payload = {
      "email": emailController.text.toLowerCase(),
      "password": passwordController.text,
    };

    try {
      await user.signIn(context, payload);

      if (user.userData?.statusCode == 200) {
        // if (!mounted) return; // Check if widget is still mounted before navigating
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false, // Remove all previous routes
        );
      } else {
        // Handle sign-in failure
        debugPrint('Sign-in failed: Status code is not 200');
      }
    } catch (error) {
      // Handle any errors that occur during sign-in
      debugPrint('Sign-in failed: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      emailController: emailController,
      passwordController: passwordController,
      onSubmit: handleOnSubmit, // Pass the Future-returning function
    );
  }
}
