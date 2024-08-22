import 'package:flutter/material.dart';
import 'package:ontrigo/API/controller/auth.controller.dart';
import 'package:ontrigo/API/models/user_data.dart';

class UserProvider extends ChangeNotifier {
  UserData? _userData;

  UserData? get userData => _userData;

  Future<UserClass?> signIn(
      BuildContext context, Map<String, dynamic> payload) async {
    try {
      final response = await AuthController().signIn(context, payload);

      if (response?.statusCode == 200) {
        _userData = response;
        notifyListeners();
        return _userData?.data;
      } else {
        // Handle case where response is not UserData
        debugPrint('SignIn did not return UserData ${response?.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error Signing In: $e');
      return null;
    }
  }
}
