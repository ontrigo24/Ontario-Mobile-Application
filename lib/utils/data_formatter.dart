import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class DataFormatter {
  /// Formats the input date string [dateStr] from 'yyyy-MM-ddTHH:mm:ss.sssZ' to 'd MMMM yyyy'.
  /// Example: '2024-04-19T19:27:06.116Z' -> '19 April 2024'
  static String formatDate(String dateStr) {
    try {
      // Parse the input string to a DateTime object
      DateTime dateTime = DateTime.parse(dateStr);

      // Format the DateTime object to the desired format
      String formattedDate = DateFormat('d MMMM yyyy').format(dateTime);

      return formattedDate;
    } catch (e) {
      // Handle any parsing or formatting errors
      debugPrint('Error formatting date: $e');
      return dateStr; // Return the original string if there is an error
    }
  }

  /// Formats the input date string [dateString] based on the [created] flag.
  /// If [created] is true, formats to 'dd MMM yyyy', otherwise to 'dd MMM'.
  /// Example: '2024-04-19T19:27:06.116Z' -> '19 Apr 2024' or '19 Apr'
  static String formatDateWithFlag(String dateString, bool created) {
    try {
      DateTime date = DateTime.parse(dateString);
      String formattedDate = created
          ? DateFormat('dd MMM yyyy').format(date)
          : DateFormat('dd MMM').format(date);

      return formattedDate;
    } catch (e) {
      debugPrint('Error formatting date with flag: $e');
      return "";
    }
  }

  /// Formats the input time string [timeString] to 'h:mm a'.
  /// Example: '19:27:06' -> '7:27 PM'
  static String formatTimeWithoutSeconds(String timeString) {
    try {
      DateTime dateTime = DateTime.parse('2022-01-01 $timeString');
      String formattedTime = DateFormat('h:mm a').format(dateTime);
      return formattedTime;
    } catch (e) {
      debugPrint('Error formatting time: $e');
      return "${e.toString().split(" ")[4]} ${e.toString().split(" ")[5]}";
    }
  }
}
