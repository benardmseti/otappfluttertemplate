import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// navigator and scaffold messenger keys
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class PageNavigator {
  // navigate to the next page
  Future nextPage({required Widget page}) {
    return navigatorKey.currentState!.push(
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  // navigate to the next page only, removing all previous routes
  Future nextPageOnly({required Widget page}) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }
}
