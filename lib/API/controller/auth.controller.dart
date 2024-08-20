// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user_data.dart';
import '../services/api_client.dart';
import '../services/helper/api_error.dart';
import '../services/helper/api_error_handler.dart';

class AuthController {
  var client = http.Client();

  Future<UserData?> signIn(BuildContext context, Map<String, dynamic> payload) async {
    debugPrint('Authenticating data with payload: $payload');
    final String requestBody = json.encode(payload);

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signin'),
        body: requestBody,
        headers: {
          'Content-Type': 'application/json',
        },
        // Optionally handle redirect by manually inspecting headers
      );

      // Debug print response status and body
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');
      debugPrint('Response Headers: ${response.headers}');

      // Handle redirect if needed
      if (response.statusCode == 308) {
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          debugPrint('Redirecting to: $redirectUrl');
          // Optionally make a new request to the redirect URL
          // var newResponse = await http.get(Uri.parse(redirectUrl));
          // Handle new response if necessary
        }
      }

      // Check if the response has a successful status code
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        if (responseData.containsKey('data')) {
          Map<String, dynamic> userData = responseData['data'];

          return UserData(
            statusCode: responseData['statusCode'],
            message: responseData['message'],
            data: User.fromJson(userData),
            success: responseData['success'],
          );
        } else {
          debugPrint('Data key not found in the response.');
        }
      } else {
        debugPrint('Error: ${response.statusCode}, ${response.reasonPhrase}, ${response.body}');
        throw ApiError(
          statusCode: response.statusCode,
          message: "Failed to authenticate",
          details: response.body,
        );
      }
    } catch (error) {
      debugPrint('Error: $error');
      ApiErrorHandler.showErrorToast(context, error);
    }

    return null;
  }

  // Future<User?> signUp(BuildContext context, payload) async {
  //   try {
  //     debugPrint(payload.toString());

  //     // Make the POST request
  //     var response = await http.post(
  //       Uri.parse('$baseUrl/auth/signup'),
  //       body: json.encode(payload),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     debugPrint('Response: ${response.body}');

  //     // Check if the response has a successful status code
  //     if (response.statusCode == 200) {
  //       var res = json.decode(response.body);

  //       // Check if the user key exists in the response
  //       if (res.containsKey('body')) {
  //         Map<String, dynamic> userData = res['body'];

  //         // Access user data
  //         User user = User(
  //           message: res['message'],
  //           user: UserClass.fromJson(userData),
  //         );

  //         debugPrint('User Registered: ${user.user?.token}');
  //         return user;
  //       } else {
  //         debugPrint('User key not found in the response.');
  //       }
  //     } else {
  //       debugPrint(
  //           'Error: ${response.statusCode}, ${response.reasonPhrase}, $response');
  //       throw ApiError(
  //         statusCode: response.statusCode,
  //         message: "Failed to fetch data",
  //         details: response.body,
  //       );
  //     }
  //   } catch (error) {
  //       ApiErrorHandler.showErrorToast(context, error);
  //     debugPrint('Error: $error');
  //   }
  //   return null;
  // }
}
