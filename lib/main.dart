import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:otappfluttertemplate/config/dependencies.dart';
import 'package:otappfluttertemplate/routing/router.dart';
import 'package:otappfluttertemplate/utils/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  if (kReleaseMode) {
    await SentryFlutter.init(
      (options) {
        options.dsn = '';
      },
      appRunner: () {
        runApp(MainApp());
      },
    );
  } else {
    runApp(MainApp());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light, // Or system or dark.
        navigatorKey:
            navigatorKey, // use as global navigator key for app navigation
        home: Scaffold(body: Center(child: Text('Hello Otapp!'))),
      ),
    );
  }
}
