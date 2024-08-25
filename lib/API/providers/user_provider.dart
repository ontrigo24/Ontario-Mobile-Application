import 'package:flutter/material.dart';
import 'package:ontrigo/API/controller/auth.controller.dart';
import 'package:ontrigo/API/models/user_data.dart';

import '../services/helper/api_error.dart';

class UserProvider extends ChangeNotifier {
  UserData? _userData;

  UserData? get userData => _userData;

  final AuthController _authController = AuthController();

  Future<UserClass?> signIn(
      BuildContext context, Map<String, dynamic> payload) async {
    try {
      final response = await _authController.signIn(context, payload);

      if (response?.statusCode == 200) {
        _userData = response;
        notifyListeners();
        return _userData?.data;
      } else {
        debugPrint('SignIn did not return UserData: ${response?.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error Signing In: $e');
      return null;
    }
  }

  Future<UserClass?> signUp(
      BuildContext context, Map<String, dynamic> payload) async {
    try {
      final response = await _authController.signUp(context, payload);

      if (response?.statusCode == 200) {
        _userData = response;
        notifyListeners();
        return _userData?.data;
      } else {
        debugPrint('SignUp did not return UserData: ${response?.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error Signing Up: $e');
      return null;
    }
  }

  Future<void> sendOtp(Map<String, String> payload) async {
    try {
      final response = await _authController.sendOtp(payload);

      // Handle successful response
      if (response['statusCode'] == 200) {
        notifyListeners();
      } else {
        debugPrint('Failed to send OTP: ${response['statusCode']}');
        throw ApiError(
          statusCode: response['statusCode'],
          message: "Failed to send OTP",
          details: response.toString(),
        );
      }
    } catch (e) {
      debugPrint('Error Sending OTP: $e');
      throw ApiError(
        statusCode: 500,
        message: "An error occurred during the OTP request",
        details: e.toString(),
      );
    }
  }

  Future<dynamic> forgotPassword(
      BuildContext context, Map<String, String> payload) async {
    try {
      final response = await _authController.forgotPassword(payload);

      // Handle successful response
      if (response['statusCode'] == 200) {
        _userData?.statusCode = response['statusCode'];
        notifyListeners();
        return response;
      } else {
        debugPrint('Failed to reset Password: ${response['statusCode']}');
        throw ApiError(
          statusCode: response['statusCode'],
          message: "Failed to reset Password",
          details: response.toString(),
        );
      }
    } catch (e) {
      debugPrint('Error Resetting Password: $e');
      throw ApiError(
        statusCode: 500,
        message: "An error occurred during Password reset",
        details: e.toString(),
      );
    }
  }
}
