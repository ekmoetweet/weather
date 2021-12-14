import 'package:flutter/material.dart';

class TraverseIndexModel extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  void incrementIndex(int _max) {
    _index++;
    if (_index > _max) {
      _index = _max;
    }
    notifyListeners();
  }

  void deIncrementIndex() {
    _index--;
    if (_index < 0) {
      _index = 0;
    }
    notifyListeners();
  }
}