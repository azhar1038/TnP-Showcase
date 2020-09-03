import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/app/router.gr.dart';
import 'package:tnp/datamodels/user.dart';
import 'package:tnp/managers/news_manager.dart';
import 'package:tnp/managers/notification_manager.dart';
import 'package:tnp/managers/theme_manager.dart';
import 'package:tnp/services/api/logout_api.dart';
import 'package:tnp/services/database_service.dart';
import 'package:tnp/services/package_info_service.dart';
import 'package:tnp/services/shared_pref_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SettingsViewModel extends BaseViewModel {
  ThemeManager _themeManager;
  PackageInfoService _pis;
  LogoutApi _logoutApi;
  DialogService _dialogService;
  NavigationService _navigationService;
  SharedPrefService _sharedPrefService;
  DatabaseService _databaseService;
  NewsManager _newsManager;
  NotificationManager _notificationManager;

  SettingsViewModel() {
    _themeManager = locator<ThemeManager>();
    _logoutApi = locator<LogoutApi>();
    _dialogService = locator<DialogService>();
    _navigationService = locator<NavigationService>();
    _sharedPrefService = locator<SharedPrefService>();
    _newsManager = locator<NewsManager>();
    _notificationManager = locator<NotificationManager>();
    if(!kIsWeb){
      _databaseService = locator<DatabaseService>();
      _pis = locator<PackageInfoService>();
    }
  }

  ThemeType get theme => _themeManager.theme;

  String get appVersion{
    if(kIsWeb) return version;
    else return _pis.appVersion;
  }

  void changeTheme(ThemeType newTheme) {
    if (newTheme != _themeManager.theme) {
      _themeManager.changeTheme(newTheme);
      _sharedPrefService.theme = newTheme;
    }
  }

  void logout() async {
    User user = _sharedPrefService.user;
    setBusy(true);
    bool success, _error = false;
    _dialogService.showCustomDialog(
        customData: DialogType.Wait, title: 'Logging Out...');
    try {
      success = await _logoutApi.logout(
          user.regn, user.passw, user.email, user.token);
      if (!success) _error = true;
    } catch (e) {
      print(e);
      _error = true;
    }
    if (_error) {
      _dialogService.completeDialog(DialogResponse());
      DialogResponse res = await _dialogService.showCustomDialog(
        customData: DialogType.Confirm,
        title: 'Error',
        description:
            'Failed to logout. Would you like to go to login page instead?',
      );
      _error = !res.confirmed;
    }
    if (!_error) {
      try {
        _sharedPrefService.user = User();
        _databaseService.deleteTable(DatabaseService.NewsTable);
        _databaseService.deleteTable(DatabaseService.NotificationTable);
        _newsManager.dispose();
        _notificationManager.dispose();
      } catch (e) {
        print(e);
      }
    }
    if (!_error) {
      _navigationService.clearStackAndShow(Routes.validateForm);
    }
  }
}
