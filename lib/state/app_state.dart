import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  String currentFilter = '';

  void updateFilter(String newFilter) {
    currentFilter = newFilter;
    notifyListeners();
  }
}
