
class ApiError {
  final int statusCode;
  final String message;
  final dynamic details;

  ApiError({required this.statusCode, required this.message, this.details});

  @override
  String toString() {
    return 'ApiError: $statusCode - $message, Details: $details';
  }
}