import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_data.dart';

abstract class AuthService {
  Future<UserCredential?> signInWithGoogle();
  Future<UserCredential?> signInWithFacebook();
  Future<UserData?> signUpWithGoogle(BuildContext context);
}

abstract class ApiService {
  Future<UserData?> signIn(BuildContext context, Map<String, dynamic> payload);
  Future<UserData?> signUp(BuildContext context, Map<String, dynamic> payload);
  Future<Map<String, dynamic>> sendOtp(Map<String, String> payload);
  Future<Map<String, dynamic>> forgotPassword(Map<String, String> payload);
}

abstract class ErrorHandlerService {
  void showError(BuildContext context, Object error);
}
