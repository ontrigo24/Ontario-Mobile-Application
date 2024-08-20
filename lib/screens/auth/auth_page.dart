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

  void handleOnSubmit() {
    final user = Provider.of<UserProvider>(context, listen: false);
    final payload = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    user.signIn(context, payload).then((_) {
      if (user.userData?.statusCode == 200) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false, // Remove all previous routes
          );
        });
      } else {
        // Handle sign-in failure if necessary
      }
    }).catchError((error) {
      // Handle any errors that occur during sign-in
      debugPrint('Sign-in failed: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      emailController: emailController,
      passwordController: passwordController,
      onSubmit: handleOnSubmit,
    );
  }
}
