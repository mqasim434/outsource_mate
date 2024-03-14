import 'package:flutter/foundation.dart';

class NavProvider extends ChangeNotifier{
  String? _selectedLabel = 'Home';

  String? get selectedLabel => _selectedLabel;

  void changeSelectedLabel(String? label){
    _selectedLabel = label;
    notifyListeners();
  }

}