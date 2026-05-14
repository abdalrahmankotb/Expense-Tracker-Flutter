import 'package:flutter/material.dart';

class ToggleProvider extends ChangeNotifier {
  bool _isWeekly = true;

  bool get isWeekly => _isWeekly;

  void setWeekly(bool val) {
    _isWeekly = val;
    notifyListeners();
  }

  void toggle() {
    _isWeekly = !_isWeekly;
    notifyListeners();
  }
}
