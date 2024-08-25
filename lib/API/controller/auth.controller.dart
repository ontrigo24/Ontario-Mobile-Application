// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_data.dart';
import '../services/api_client.dart';
import '../services/helper/api_error.dart';
import '../services/helper/api_error_handler.dart';

/// Controller class responsible for handling authentication logic.
class AuthController {
  // HTTP client for making API requests
  final http.Client client = http.Client();

  /// Signs in the user using the provided authentication payload.
  ///
  /// The [context] is used for displaying error messages through [ScaffoldMessenger].
  /// The [payload] contains authentication data such as the provider and token.
  /// Returns a [UserData] object if authentication is successful, otherwise returns `null`.
  Future<UserData?> signIn(
      BuildContext context, Map<String, dynamic> payload) async {
    debugPrint('Authenticating data with payload: $payload');
    final String requestBody = json.encode(payload);

    try {
      // Make the POST request to the sign-in endpoint
      final response = await client.post(
        Uri.parse('$baseUrl/auth/signin'),
        body: requestBody,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      // Handle potential HTTP 308 redirect status
      if (response.statusCode == 308) {
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          debugPrint('Redirecting to: $redirectUrl');
        }
      }

      // Process a successful response
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Extract and return user data if available
        if (responseData.containsKey('data')) {
          final Map<String, dynamic> userData = responseData['data'];

          return UserData(
            statusCode: responseData['statusCode'],
            message: responseData['message'],
            data: UserClass.fromJson(userData),
            success: responseData['success'],
          );
        } else {
          debugPrint('Data key not found in the response.');
        }
      } else {
        // Handle unsuccessful response
        debugPrint(
            'Error: ${response.statusCode}, ${response.reasonPhrase}, ${response.body}');
        throw ApiError(
          statusCode: response.statusCode,
          message: "Failed to authenticate",
          details: response.body,
        );
      }
    } catch (error) {
      // Handle any errors that occur during the API call
      debugPrint('Error: $error');
      ApiErrorHandler.showErrorToast(context, error);
    }

    return null;
  }

  /// Initiates the Google Sign-In process and returns the user's credentials.
  ///
  /// If the Google Sign-In is successful, a [UserCredential] is returned; otherwise, returns `null`.
  Future<UserCredential?> signInGoogleCredentials() async {
    try {
      // Start the Google Sign-In process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth != null) {
        // Create and return a credential using the obtained Google authentication details
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      // Log any errors that occur during Google Sign-In
      debugPrint('Google sign-in failed: $e');
    }
    return null;
  }

  /// Handles the full Google Sign-In flow, including Firebase authentication and server-side processing.
  ///
  /// The [context] is used for displaying success or error messages via [ScaffoldMessenger].
  /// Returns a [UserData] object if the sign-in and server-side processing are successful, otherwise returns `null`.
  Future<UserData?> signInWithGoogle(BuildContext context) async {
    try {
      // Sign in the user with Google and obtain credentials
      final UserCredential? userCredential = await signInGoogleCredentials();
      final String? idToken = await userCredential?.user?.getIdToken();

      if (idToken != null) {
        // Prepare the payload for the server-side API request
        final Map<String, String> payload = {
          "provider": "google",
          "providerToken": idToken,
        };
        debugPrint('Payload: $payload');

        // Make the POST request to the server to complete the sign-in process
        final response = await client.post(
          Uri.parse('$baseUrl/auth/fb/signup'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(payload),
        );

        // Handle server response and display appropriate feedback
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign-in successful!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sign-in failed: ${response.body}')),
          );
        }
      }
    } catch (e) {
      // Handle any errors that occur during the Google sign-in or server-side processing
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
    return null;
  }

  Future<UserData?> signUp(
      BuildContext context, Map<String, dynamic> payload) async {
    debugPrint('Authenticating data with payload: $payload');
    final String requestBody = json.encode(payload);

    try {
      // Make the POST request to the sign-in endpoint
      final response = await client.post(
        Uri.parse('$baseUrl/auth/signUp'),
        body: requestBody,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      // Handle potential HTTP 308 redirect status
      if (response.statusCode == 308) {
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          debugPrint('Redirecting to: $redirectUrl');
        }
      }

      // Process a successful response
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Extract and return user data if available
        if (responseData.containsKey('data')) {
          final Map<String, dynamic> userData = responseData['data'];

          return UserData(
            statusCode: responseData['statusCode'],
            message: responseData['message'],
            data: UserClass.fromJson(userData),
            success: responseData['success'],
          );
        } else {
          debugPrint('Data key not found in the response.');
        }
      } else {
        // Handle unsuccessful response
        debugPrint(
            'Error: ${response.statusCode}, ${response.reasonPhrase}, ${response.body}');
        throw ApiError(
          statusCode: response.statusCode,
          message: "Failed to authenticate",
          details: response.body,
        );
      }
    } catch (error) {
      // Handle any errors that occur during the API call
      debugPrint('Error: $error');
      ApiErrorHandler.showErrorToast(context, error);
    }

    return null;
  }

  Future<Map<String, dynamic>> sendOtp(Map<String, String> payload) async {
    debugPrint('Sending OTP to User: $payload');
    final String requestBody = json.encode(payload);

    try {
      // Make the POST request to the send OTP endpoint
      final response = await client.post(
        Uri.parse('$baseUrl/auth/sendOtp'),
        body: requestBody,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      // Follow redirect if HTTP 308 status is returned
      if (response.statusCode == 308) {
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          debugPrint('Redirecting to: $redirectUrl');
          // Make a follow-up request to the redirect URL
          final redirectResponse = await client.post(
            Uri.parse(redirectUrl),
            body: requestBody,
            headers: {
              'Content-Type': 'application/json',
            },
          );

          if (redirectResponse.statusCode == 200) {
            final responseData = json.decode(redirectResponse.body);
            return responseData;
          } else {
            debugPrint(
                'Error on redirect: ${redirectResponse.statusCode}, ${redirectResponse.reasonPhrase}, ${redirectResponse.body}');
            throw ApiError(
              statusCode: redirectResponse.statusCode,
              message: "Failed to authenticate after redirect",
              details: redirectResponse.body,
            );
          }
        }
      }

      // Process a successful response
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData;
      } else {
        // Handle unsuccessful response
        debugPrint(
            'Error: ${response.statusCode}, ${response.reasonPhrase}, ${response.body}');
        throw ApiError(
          statusCode: response.statusCode,
          message: "Failed to authenticate",
          details: response.body,
        );
      }
    } catch (error) {
      // Handle any errors that occur during the API call
      debugPrint('Error: $error');
      throw ApiError(
        statusCode: 500,
        message: "An error occurred during the request",
        details: error.toString(),
      );
    }
  }

  Future<Map<String, dynamic>> forgotPassword(
      Map<String, String> payload) async {
    debugPrint('Resetting Password: $payload');
    final String requestBody = json.encode(payload);

    try {
      // Make the POST request to the forgot password endpoint
      final response = await client.post(
        Uri.parse('$baseUrl/auth/forgotPassword'),
        body: requestBody,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      // Follow redirect if HTTP 308 status is returned
      if (response.statusCode == 308) {
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          debugPrint('Redirecting to: $redirectUrl');
          // Make a follow-up request to the redirect URL
          final redirectResponse = await client.post(
            Uri.parse(redirectUrl),
            body: requestBody,
            headers: {
              'Content-Type': 'application/json',
            },
          );

          if (redirectResponse.statusCode == 200) {
            final responseData = json.decode(redirectResponse.body);
            return responseData;
          } else {
            debugPrint(
                'Error on redirect: ${redirectResponse.statusCode}, ${redirectResponse.reasonPhrase}, ${redirectResponse.body}');
            throw ApiError(
              statusCode: redirectResponse.statusCode,
              message: "Failed to authenticate after redirect",
              details: redirectResponse.body,
            );
          }
        }
      }

      // Process a successful response
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData;
      } else {
        // Handle unsuccessful response
        debugPrint(
            'Error: ${response.statusCode}, ${response.reasonPhrase}, ${response.body}');
        throw ApiError(
          statusCode: response.statusCode,
          message: "Failed to authenticate",
          details: response.body,
        );
      }
    } catch (error) {
      // Handle any errors that occur during the API call
      debugPrint('Error: $error');
      throw ApiError(
        statusCode: 500,
        message: "An error occurred during the request",
        details: error.toString(),
      );
    }
  }
}
