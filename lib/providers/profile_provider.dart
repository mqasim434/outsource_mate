import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier{
  bool _isEditing = false;

  bool get isEditing => _isEditing;

  void switchEditing(bool value){
    _isEditing = value;
    notifyListeners();
  }
}