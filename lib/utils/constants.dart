import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:otappfluttertemplate/utils/routers.dart';
import 'package:url_launcher/url_launcher.dart';

const padding = 25.0;
const elevation = 7.0;
const paycardwidth = 80.0;
const detailsfontsize = 16.0;

String formatPhoneNumber(String phoneNumber, String countryCode) {
  if (phoneNumber.startsWith('0') || phoneNumber.startsWith('1')) {
    return countryCode + phoneNumber.substring(1);
  }
  return countryCode + phoneNumber;
}

bool isValidEmail(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

class HeroTags {
  static const String carousel = "carousel";
  static const String grid = "grid";

  static String getCarouselTag(String movieId) => "${carousel}_$movieId";
  static String getGridTag(String movieId) => "${grid}_$movieId";
}

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



Future<void> launchURL(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}

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
