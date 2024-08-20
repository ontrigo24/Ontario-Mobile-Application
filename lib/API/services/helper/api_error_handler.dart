import 'package:flutter/material.dart';

import 'api_error.dart';

class ApiErrorHandler {
  static void showErrorToast(BuildContext context, dynamic error) {
    String errorMessage = _getErrorMessage(error);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static String _getErrorMessage(dynamic error) {
    if (error is ApiError) {
      // Handle ApiError specifically
      switch (error.statusCode) {
        case 400:
          return 'Bad request: ${error.message}';
        case 401:
          return 'Unauthorized: ${error.message}';
        case 403:
          return 'Forbidden: ${error.message}';
        case 404:
          return 'Not found: ${error.message}';
        case 405:
          return 'Method not allowed: ${error.message}';
        case 408:
          return 'Request timeout: ${error.message}';
        case 429:
          return 'Too many requests: ${error.message}';
        case 500:
          return 'Internal server error: ${error.message}';
        case 502:
          return 'Bad gateway: ${error.message}';
        case 503:
          return 'Service unavailable: ${error.message}';
        case 504:
          return 'Gateway timeout: ${error.message}';
        default:
          return 'An error occurred: ${error.message}';
      }
    } else if (error is FlutterError) {
      // Handle FlutterError
      return 'Flutter error: ${error.toString()}';
    } else {
      // Handle other types of errors
      return 'An unknown error occurred';
    }
  }
}