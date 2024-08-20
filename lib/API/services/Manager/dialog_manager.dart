import 'package:flutter/material.dart';

class DialogManager {

  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Do something when 'OK' is pressed
          },
        ),
      ),
    );
  }
  // Show error dialog
  static void showErrorDialog({
    required BuildContext context,
    String title = 'Error',
    String description = '',
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8.0),
                Text(description,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Ok'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Show loading dialog
  static void showLoading(BuildContext context, [String? message]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 8.0),
                Text(message ?? 'Loading...'),
              ],
            ),
          ),
        );
      },
    );
  }

  // Hide loading dialog
  static void hideLoading(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  // Show snackbar
  static void showSnackbar({
    required BuildContext context,
    required String message,
    String title = 'Error',
    SnackBarPosition position = SnackBarPosition.top,
    Color backgroundColor = Colors.red,
    Color textColor = Colors.white,
  }) {
    final snackBar = SnackBar(
      content: Text(
        '$title${title == '' ? '' : ':'} $message',
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar)
      ..showSnackBarAtPosition(snackBar, SnackBarPosition.top);
  }

  // Show login error dialog
  static void showLoginErrorDialog(
      BuildContext context, String title, VoidCallback onAction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: const Text('Something went wrong, please try again!'),
        actions: [
          TextButton(
            onPressed: onAction,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

enum SnackBarPosition { top, bottom }

extension ScaffoldMessengerExtension on ScaffoldMessengerState {
  void showSnackBarAtPosition(SnackBar snackBar, SnackBarPosition position) {
    clearSnackBars();
    showSnackBar(snackBar);
    // This ensures the snackbar is positioned at the desired location.
    final isTop = position == SnackBarPosition.top;
    if (isTop) {
      final mediaQuery = MediaQuery.of(context);
      final inset = mediaQuery.padding.top;
      Overlay.of(context).insert(
        OverlayEntry(
          builder: (context) => Positioned(
            top: inset,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: snackBar,
            ),
          ),
        ),
      );
    }
  }
}
