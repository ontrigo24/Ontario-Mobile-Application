import 'package:flutter/material.dart';

import '../../../interfaces/auth.dart';
import '../../helper/api_error.dart';

class ApiErrorHandler implements ErrorHandlerService {
  @override
  void showError(BuildContext context, Object error) {
    String errorMessage = "An unknown error occurred";
    if (error is ApiError) {
      errorMessage = error.message;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }
}
