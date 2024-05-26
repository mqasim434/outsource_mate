import 'package:flutter/cupertino.dart';

class BottomNavbarProvider extends ChangeNotifier{
  int _selectedIndex = 0;
  final PageController _controller = PageController();

  int get selectedIndex => _selectedIndex;
  PageController get controller => _controller;

  void changeIndex(int index){
    _selectedIndex = index;
    controller.animateToPage(index, duration: const Duration(milliseconds: 1), curve: Curves.easeInOut,);
    notifyListeners();
  }

  String? _selectedLabel = 'Home';

  String? get selectedLabel => _selectedLabel;

  void changeSelectedLabel(String? label){
    _selectedLabel = label;
    notifyListeners();
  }
}