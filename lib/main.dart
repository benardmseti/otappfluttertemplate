import 'package:flutter/material.dart';
import 'package:otappfluttertemplate/utils/routers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,// use as global navigator key for app navigation
      home: Scaffold(body: Center(child: Text('Hello Otapp!'))),
    );
  }
}
