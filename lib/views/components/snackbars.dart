import 'package:flutter/material.dart';
import 'package:otappfluttertemplate/routing/router.dart';

/// Shows a snack bar with the given message.
///
/// The snack bar is amber colored and shows for 6 seconds, with a close
/// button.
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
