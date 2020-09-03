import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/datamodels/user.dart';

@preResolve
@singleton
class SharedPrefService {
  static SharedPrefService _instance;
  static SharedPreferences _preferences;

  static const String UserKey = 'user';
  static const String ThemeKey = 'intTheme';

  @factoryMethod
  static Future<SharedPrefService> getInstance() async {
    if (_instance == null) {
      _instance = SharedPrefService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  User get user {
    var userJson = _getFromDisk(UserKey);
    if (userJson == null) return null;
    return User.fromJson(jsonDecode(userJson));
  }

  set user(User userToSave) {
    _saveToDisk<String>(UserKey, jsonEncode(userToSave.toJson()));
  }

  ThemeType get theme {
    int theme = _getFromDisk(ThemeKey);
    switch (theme) {
      case 0:
        return ThemeType.Light;
      case 1:
        return ThemeType.Dark;
      case 2:
        return ThemeType.Black;
      default:
        return ThemeType.Light;
    }
  }

  set theme(ThemeType theme) {
    int themeNum;
    switch (theme) {
      case ThemeType.Light:
        themeNum = 0;
        break;
      case ThemeType.Dark:
        themeNum = 1;
        break;
      case ThemeType.Black:
        themeNum = 2;
        break;
      default:
        themeNum = 0;
        break;
    }
    _saveToDisk<int>(ThemeKey, themeNum);
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    print('(TRACE) SharedPrefService: _getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T value) {
    print(
        '(TRACE) SharedPrefService:_saveStringToDisk. key: $key value: $value');
    if (value is String)
      _preferences.setString(key, value);
    else if (value is int) _preferences.setInt(key, value);
  }
}
