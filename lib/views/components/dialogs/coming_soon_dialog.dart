import 'package:flutter/material.dart';

/// Displays a dialog indicating a feature is coming soon.
///
/// The dialog will display a message indicating that the feature 
/// for the given [platform] is coming soon, along with a title
/// "Coming Soon!". The dialog has an 'OK' button to dismiss it.
///
/// Parameters:
/// - [context]: The build context in which to show the dialog.
/// - [platform]: A string representing the platform or feature name.
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
