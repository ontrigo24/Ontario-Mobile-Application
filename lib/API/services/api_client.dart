// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print,, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/api_error.dart';
import 'helper/api_error_handler.dart';

enum PlatformDeployed { vercel, aws, local, production }

Map<PlatformDeployed, List<String>> domains = {
  PlatformDeployed.vercel: ['https://ontrigo-backend.vercel.app'], // staging 
  PlatformDeployed.aws: [], // socket connection 
  PlatformDeployed.local: ['http://localhost:8080'], // local dev test
  PlatformDeployed.production: [] // Prod
};

// Set the platform you want to use here
const PlatformDeployed currentPlatform = PlatformDeployed.vercel;
// const PlatformDeployed socketPlatform = PlatformDeployed.aws;

// set domains
String API_BASE_URL = domains[currentPlatform]![0];
// String SOCKET_URL = domains[socketPlatform]![0];

String baseUrl = '$API_BASE_URL/api';

class ApiClient {
  var client = http.Client();

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('x-auth-token')!;
    var data = token;
    return data;
  }

  // Get request
  Future<dynamic> get(BuildContext context, String route) async {
    try {
      var url = Uri.parse(baseUrl + route);
      var token = await getToken();
      if (token == '') {
        throw ApiError(statusCode: 401, message: "Unauthorized: Token is null");
      }
      var _headers = {
        'Content-Type': 'application/json',
        'x-auth-token': token,
      };
      var response = await client.get(url, headers: _headers);
      if (response.statusCode == 200) {
        // print('Response of ApiClient for $route: ${response.body}');
        return response.body;
      } else {
        throw ApiError(
          statusCode: response.statusCode,
          message: "Failed to fetch data",
          details: response.body,
        );
      }
    } catch (e) {
      print('Error in get request: $e');
      if (e is ApiError) {
        // ignore: use_build_context_synchronously
        ApiErrorHandler.showErrorToast(context, e);
      }
      return null;
    }
  }

  Future<Map<String, dynamic>> post(String route, dynamic object) async {
    print("Procssing ApiClient with:\n $object");

    // Get Token
    var token = await getToken();
    // Parsing URL
    var url = Uri.parse(baseUrl + route);
    // Header Config
    var _headers = <String, String>{
      'Content-Type': 'application/json',
      'x-auth-token': token,
    };
    var _payload = jsonEncode(object);

    print("$_payload, Url : $url, \nToken : $token");

    // Make the POST Request
    try {
      final http.Response response = await http.post(
        url,
        body: _payload,
        headers: _headers,
      );

      print("Response from ApiClient : ${response.body}");

      // Check if the request was successful (status code 2xx)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Parse the response body
        return jsonDecode(response.body);
      } else {
        var errorJson = jsonDecode(response.body);
        var errorMessage = errorJson["message"] ?? "Error";
        print('Error: ${response.statusCode}, $errorMessage');
        throw ApiError(
          statusCode: response.statusCode,
          message: "Failed to post data",
          details: response.body,
        );
      }
    } catch (error) {
      print('Error: $error');
      print('Error in post request: $error');
      throw ApiError(
        statusCode: 500,
        message: "Internal server error",
        details: error.toString(),
      );
    }
  }

  Future<dynamic> postJoinEvent(String eventID) async {
    var response = await post('/events/join', {"eventID": eventID});
    return response;
  }

  // Put request code snippet
  Future<dynamic> put(
    String route,
    dynamic object, {
    Map<String, String>? headers,
    String? authToken,
  }) async {
    // Get Token
    var token = await getToken();

    var url = Uri.parse(baseUrl + route);
    var _payload = json.encode(object);

    var _headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (authToken != null) 'x-auth-token': token,
      if (headers != null) ...headers,
    };

    var response = await http.put(
      url,
      headers: _headers,
      body: _payload,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw ApiError(
        statusCode: response.statusCode,
        message: "Failed to update data",
        details: response.body,
      );
    }
  }

  Future<dynamic> delete(
    String route, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    var url = Uri.parse('$baseUrl$route');
    var token = await getToken();

    var defaultHeaders = {
      'Content-Type': 'application/json',
      'x-auth-token': token,
    };

    // Merge custom headers with default headers
    var _headers = {...defaultHeaders, if (headers != null) ...headers};

    try {
      var response = await client.delete(
        url,
        headers: _headers,
        body: body != null ? json.encode(body) : null,
      );

      print(
          "Response from ApiClient : ${response.body}, status code : ${response.statusCode}");

      if (response.statusCode == 200) {
        return response;
      } else {
        var errorJson = json.decode(response.body);
        var errorMessage = errorJson["message"] ?? "Error";
        print('Error: ${response.statusCode}, $errorMessage');
        throw ApiError(
          statusCode: response.statusCode,
          message: errorMessage,
          details: response.body,
        );
      }
    } catch (error) {
      print('Error in delete request: $error');
      throw ApiError(
        statusCode: 500,
        message: "Internal server error",
        details: error.toString(),
      );
    }
  }
}
