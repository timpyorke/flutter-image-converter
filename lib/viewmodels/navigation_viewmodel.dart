import 'package:flutter/foundation.dart';

class NavigationViewModel extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _isLoading = false;

  int get selectedIndex => _selectedIndex;
  bool get isLoading => _isLoading;

  Future<void> selectTab(int index) async {
    if (_selectedIndex != index) {
      _isLoading = true;
      notifyListeners();

      // Simulate loading for smooth transition
      await Future.delayed(const Duration(milliseconds: 350));

      _selectedIndex = index;
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectConvertTab() => selectTab(0);
  void selectResizeTab() => selectTab(1);

  bool get isConvertSelected => _selectedIndex == 0;
  bool get isResizeSelected => _selectedIndex == 1;
}
