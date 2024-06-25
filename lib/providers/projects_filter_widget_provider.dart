import 'package:flutter/widgets.dart';

class ProjectsFilterWidgetProvider extends ChangeNotifier {
  String selectedLabel = 'In Progress';

  void switchLabel(String label) {
    selectedLabel = label;
    notifyListeners();
  }
}
