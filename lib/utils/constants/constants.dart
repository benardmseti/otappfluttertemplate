import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:otappfluttertemplate/routing/router.dart';
import 'package:url_launcher/url_launcher.dart';

/// A container for app wide constants
///
/// It provices a centralized location for constant values, making it easier to
/// manage and maintain them throughout the app.
abstract class AppConstants {
  // e.g. fare
  static const String minimumFareAmount = '0';
  static const String maximumFareAmount = '10000000';
}

@Deprecated('Moved the constants/dimensions to a [dimens.dart] file')
const padding = 25.0;
@Deprecated('Moved the constants/dimensions to a [dimens.dart] file')
const elevation = 7.0;
@Deprecated('Moved the constants/dimensions to a [dimens.dart] file')
const paycardwidth = 80.0;

@Deprecated('Moved the [formatPhoneNumber] to a [phone_number_utils.dart] file')
String formatPhoneNumber(String phoneNumber, String countryCode) {
  if (phoneNumber.startsWith('0') || phoneNumber.startsWith('1')) {
    return countryCode + phoneNumber.substring(1);
  }
  return countryCode + phoneNumber;
}

@Deprecated('Moved the [isValidEmail] to a [email_utils.dart] file')
bool isValidEmail(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

@Deprecated('Moved the [showComingSoonDialog] to a [components/dialog] file')
void showComingSoonDialog(BuildContext context, String platform) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog.adaptive(
        title: Text('Coming Soon!'),
        content: Text("We're excited to bring $platform soon. Stay tuned!"),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

@Deprecated('Moved the [showSnackbar] to a components/snackbars file')
void showSnackbar(String? msg) {
  //show error in snackbar
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      content: Text(msg!),
      duration: const Duration(seconds: 6),
      backgroundColor: Colors.amber,
    ),
  );
}

@Deprecated('Moved the [launchURL] to a [url_utils] file')
Future<void> launchURL(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}

@Deprecated('Moved the [getFormattedDate] to a [date_utils] file')
String getFormattedDate(DateTime parsedDate) {
  try {
    // Formatting the date as "dd MMM yyyy"
    return DateFormat('dd MMM yyyy').format(parsedDate);
  } catch (e) {
    // In case of parsing error, return the original date in "dd MMM yyyy" format
    debugPrint('Date parsing error: $e');
    return DateFormat('dd MMM yyyy').format(parsedDate);
  }
}
