import 'package:flutter/foundation.dart';

/// ViewModel for Navigation state
class NavigationViewModel extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void selectTab(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  void selectConvertTab() => selectTab(0);
  void selectResizeTab() => selectTab(1);

  bool get isConvertSelected => _selectedIndex == 0;
  bool get isResizeSelected => _selectedIndex == 1;
}
