import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class DummyProvider extends ChangeNotifier {
  String _dummyData = "Initial dummy data";

  String get dummyData => _dummyData;

  void updateData(String newData) {
    _dummyData = newData;
    notifyListeners();
  }
}

/// Configure providers/dependencies for app functionalities
///
List<SingleChildWidget> get providers {
  return [
    // e.g.
    // ChangeNotifierProvider(create: (context) => SomeProvider());
    ChangeNotifierProvider<DummyProvider>(create: (context) => DummyProvider()),
  ];
}
