import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/exceptions/bad_request_exception.dart';
import 'package:tnp/exceptions/fetch_data_exception.dart';
import 'package:tnp/exceptions/timeout_exception.dart';
import 'package:tnp/exceptions/unauthorised_exception.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/datamodels/student.dart';
import 'package:tnp/datamodels/user.dart';
import 'package:tnp/managers/theme_manager.dart';
import 'package:tnp/managers/user_manager.dart';
import 'package:tnp/services/api/login_api.dart';
import 'package:tnp/services/fcm_service.dart';
import 'package:tnp/services/shared_pref_service.dart';
import 'package:tnp/app/router.gr.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginLinkFormModel extends BaseViewModel {
  LoginApi _loginApi;
  UserManager _userManager;
  SharedPrefService _sharedPrefService;
  DialogService _dialogService;
  NavigationService _navigationService;
  ThemeManager _themeManager;
  FCMService _fcmService;

  LoginLinkFormModel() {
    _loginApi = locator<LoginApi>();
    _userManager = locator<UserManager>();
    _sharedPrefService = locator<SharedPrefService>();
    _dialogService = locator<DialogService>();
    _navigationService = locator<NavigationService>();
    _themeManager = locator<ThemeManager>();
    if(!kIsWeb){
      _fcmService = locator<FCMService>();
    }
  }

  bool _error = false;

  String get studentName => _userManager.user.name;

  void reloadTheme() => _themeManager.changeTheme(_themeManager.theme);

  String validatePassword(String s) {
    if (s.isEmpty)
      return "Password cannot be empty";
    else if (s.length < 4) return "Password too short";
    return null;
  }

  Future<void> loginAndLinkDevice(String passw) async {
    Map<String, dynamic> response;
    User _user = _userManager.user;
    _user.passw = passw;
    setBusy(true);
    _dialogService.showCustomDialog(
      customData: DialogType.Wait,
      title: 'Logging In...',
    );
    bool updateToken = false;
    if(_fcmService != null) {
      String newToken = await _fcmService.getNewToken('');
      _user.token = newToken;
      updateToken = true;
    }
    try {
      response = await _loginApi.loginAndLinkDevice(_user, updateToken);
    } catch (error) {
      setBusy(false);
      _error = true;
      _dialogService.completeDialog(DialogResponse());
      _showDialogOnException(error);
    }
    _dialogService.completeDialog(DialogResponse());
    setBusy(false);
    if (!_error) {
      if (response['status']) {
        _sharedPrefService.user = _user;
        _user.student = Student.fromMap(response['student']);
        _navigationService.clearStackAndShow(Routes.home);
      } else {
        _dialogService.showCustomDialog(
          customData: DialogType.Alert,
          title: 'Login Failed!',
          description: "Seems like you have entered incorrect password.",
        );
      }
    }
  }

  void _showDialogOnException(error) {
    switch (error.runtimeType) {
      case TimeoutException:
        _dialogService.showDialog(
          title: 'Timeout Error!',
          description:
              "Couldn't connect to Server. Please check your internet connection or try again later ",
        );
        break;
      case FetchDataException:
        _dialogService.showCustomDialog(
          customData: DialogType.Alert,
          title: 'Network Error!',
          description: error.toString(),
        );
        break;
      case BadRequestException:
        _dialogService.showCustomDialog(
          customData: DialogType.Alert,
          title: 'Bad Request Error!',
          description: "If this error persists, please contact us.",
        );
        break;
      case UnauthorisedException:
        _dialogService.showCustomDialog(
          customData: DialogType.Alert,
          title: 'Unauthorised Error!',
          description: "You don't have access permission.",
        );
        break;
      default:
        _dialogService.showCustomDialog(
          customData: DialogType.Alert,
          title: 'Unknown Error!',
          description: "An unknown error has occurred. Try again later.",
        );
    }
  }
}
