import 'package:flutter/material.dart';

import '../../../../../core/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool _isLightMode = true;

  bool get isLightMode => _isLightMode;

  set isLightMode(bool value) {
    _isLightMode = value;
    notifyListeners();
  }
  void toggleMode() {
    if(_isLightMode){
      _isLightMode = false ;
    }else{
      _isLightMode = true ;
    }
    notifyListeners();
  }


  ThemeData getCurrentTheme() {
    print('=====================================================object');
    return _isLightMode ? lightMode : darkMode;  }
}
