import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Formats the given [DateTime] as "dd MMM yyyy".
///
/// If the date is invalid, it will print the error to the console
/// and return the original date in the same format.
String getFormattedDate(DateTime parsedDate) {
  try {
    return DateFormat('dd MMM yyyy').format(parsedDate);
  } catch (e) {
    debugPrint('Date parsing error: $e');
    return DateFormat('dd MMM yyyy').format(parsedDate);
  }
}
