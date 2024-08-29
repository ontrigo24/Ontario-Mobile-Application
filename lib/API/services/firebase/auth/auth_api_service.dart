import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../interfaces/auth.dart';
import '../../../models/user_data.dart';

class ApiServiceImpl implements ApiService {
  final http.Client client;
  final String baseUrl;

  ApiServiceImpl({required this.client, required this.baseUrl});

  @override
  Future<UserData?> signIn(
      BuildContext context, Map<String, dynamic> payload) async {
    return _postRequest(
      context,
      Uri.parse('$baseUrl/auth/signin'),
      payload,
    );
  }

  @override
  Future<UserData?> signUp(
      BuildContext context, Map<String, dynamic> payload) async {
    return _postRequest(
      context,
      Uri.parse('$baseUrl/auth/signUp'),
      payload,
    );
  }

  @override
  Future<Map<String, dynamic>> sendOtp(Map<String, String> payload) async {
    return _postRequestNoContext(
      Uri.parse('$baseUrl/auth/sendOtp'),
      payload,
    );
  }

  @override
  Future<Map<String, dynamic>> forgotPassword(
      Map<String, String> payload) async {
    return _postRequestNoContext(
      Uri.parse('$baseUrl/auth/forgotPassword'),
      payload,
    );
  }

  Future<UserData?> _postRequest(
    BuildContext context,
    Uri url,
    Map<String, dynamic> payload,
  ) async {
    try {
      final response = await client.post(
        url,
        body: json.encode(payload),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData.containsKey('data')) {
          final userData = responseData['data'];
          return UserData.fromJson(userData);
        }
      } else {
        // throw ApiError.fromResponse(response);
      }
    } catch (error) {
      // ApiErrorHandler().showError(context, error);
    }

    return null;
  }

  Future<Map<String, dynamic>> _postRequestNoContext(
    Uri url,
    Map<String, dynamic> payload,
  ) async {
    try {
      final response = await client.post(
        url,
        body: json.encode(payload),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'error': null};
        // throw ApiError.fromResponse(response);
      }
    } catch (error) {
      debugPrint('Error: $error');
      rethrow;
    }
  }
}
