import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/app/router.gr.dart';
import 'package:tnp/datamodels/student.dart';
import 'package:tnp/datamodels/user.dart';
import 'package:tnp/managers/user_manager.dart';
import 'package:tnp/services/api/login_api.dart';
import 'package:tnp/services/fcm_service.dart';
import 'package:tnp/services/inapp_update_service.dart';
import 'package:tnp/services/shared_pref_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class StartUpViewModel extends BaseViewModel {
  LoginApi _api;
  SharedPrefService _storage;
  NavigationService _navigator;
  UserManager _userManager;
  FCMService _fcm;
  InAppUpdateService _inAppUpdate;

  StartUpViewModel() {
    _api = locator<LoginApi>();
    _storage = locator<SharedPrefService>();
    _navigator = locator<NavigationService>();
    _userManager = locator<UserManager>();
    if (!kIsWeb) {
      _fcm = locator<FCMService>();
      _inAppUpdate = locator<InAppUpdateService>();
    }
  }

  bool _error = false;
  bool _updateAvailable = false;

  Future startupLogic() async {
    await Future.delayed(Duration(seconds: 2));
    if (kIsWeb)
      _noUpdateLogic();
    else {
      try {
        _updateAvailable = await _inAppUpdate.checkForUpdate();
      } catch (error) {
        print(error.toString());
      }
      if (!_updateAvailable)
        _noUpdateLogic();
      else
        _navigator.replaceWith(Routes.forceUpdate);
    }
  }

  void _noUpdateLogic() async {
    User _user = _storage.user;
    if (_user == null ||
        _user.regn == 0 ||
        _user.email == '' ||
        _user.passw == '') {
      _error = true;
      print("USER NULL");
    }
    Map<String, dynamic> response;
    if (!_error) {
      try {
        bool updateToken = false;
        if(!kIsWeb) {
          String newToken = await _fcm.getNewToken(_user.token ?? '');
          if (newToken != null) {
            updateToken = true;
            _user.token = newToken;
          }
        }
        _storage.user = _user;
        response = await _api.loginAndLinkDevice(_user, updateToken);
      } catch (error) {
        _error = true;
        print("RESPONSE ERROR");
      }
    }

    if (!_error && response != null) {
      if (!response['status'] ?? false) {
        _error = true;
        print("INVALID USER");
      } else {
        _user.student = Student.fromMap(response['student']);
        print("SETTING USER MANAGER STUDENT");
        _userManager.user = _user;
        _error = false;
        print("LOGGED IN SUCCESSFULLY");
      }
    } else
      _error = true;
    if (_error)
      _navigator.replaceWith(Routes.validateForm);
    else
      _navigator.replaceWith(Routes.home);
  }
}
