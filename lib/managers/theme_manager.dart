import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:injectable/injectable.dart';
import 'package:tnp/app/enums.dart';

@singleton
class ThemeManager {
  ThemeType theme;
  StreamController<ThemeType> _themeController;

  ThemeManager() {
    _themeController = StreamController<ThemeType>();
    theme = ThemeType.Light;
    _themeController.add(theme);
  }

  Stream<ThemeType> get themeStream => _themeController.stream;

  void changeTheme(ThemeType newTheme) {
    theme = newTheme;
    if (!kIsWeb)
      switch (newTheme) {
        case ThemeType.Light:
          FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
          FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
          FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
          break;
        case ThemeType.Dark:
          FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
          FlutterStatusbarcolor.setNavigationBarColor(Color(0xff272727));
          FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
          break;
        case ThemeType.Black:
          FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
          FlutterStatusbarcolor.setNavigationBarColor(Color(0xff000000));
          FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
          break;
      }
    _themeController.add(theme);
  }
}
