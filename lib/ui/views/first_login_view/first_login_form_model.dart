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

class FirstLoginFormModel extends BaseViewModel {
  UserManager _userManager = locator<UserManager>();
  LoginApi _loginApi = locator<LoginApi>();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();
  SharedPrefService _sharedPrefService = locator<SharedPrefService>();
  FCMService _fcmService = locator<FCMService>();
  ThemeManager _themeManager = locator<ThemeManager>();

  bool _error = false;

  String get studentName => _userManager.user.name;

  void reloadTheme() => _themeManager.changeTheme(_themeManager.theme);

  String validatePassword(String s) {
    if (s.isEmpty)
      return "Password cannot be empty";
    else if (s.length < 4) return "Password too short";
    return null;
  }

  String validateConfirm(String s, String c) {
    if (s.isEmpty)
      return "Password cannot be empty";
    else if (s.length < 4)
      return "Password too short";
    else if (s != c) return "Password did\'t match";
    return null;
  }

  Future<void> firstLogin(String passw) async {
    Map<String, dynamic> response, studentJson;
    User _user = _userManager.user;
    _user.passw = passw;
    setBusy(true);
    _dialogService.showCustomDialog(
      customData: DialogType.Wait,
      title: 'Registering...',
    );
    try {
      response = await _loginApi.firstLogin(_user);
    } catch (error) {
      setBusy(false);
      _dialogService.completeDialog(DialogResponse());
      _error = true;
      showDialogOnException(error);
    }
    if (!_error) {
      if (response['status'])
        _error = false;
      else {
        setBusy(false);
        _error = true;
        _dialogService.completeDialog(DialogResponse());
        await _dialogService.showCustomDialog(
          customData: DialogType.Alert,
          title: 'Registration Failed!',
          description:
              "Failed to register you for the first time. Try again later or contact us.",
        );
      }
    }
    if (!_error) {
      try {
        String _token = await _fcmService.getNewToken('');
        _user.token = _token;
        studentJson = await _loginApi.loginAndLinkDevice(_user, true);
        _user.student = Student.fromMap(studentJson['student']);
      } catch (error) {
        setBusy(false);
        _error = true;
        _dialogService.completeDialog(DialogResponse());
        showDialogOnException(error);
      }
    }
    if (!_error) {
      _sharedPrefService.user = _user;
      setBusy(false);
      _dialogService.completeDialog(DialogResponse());
      _navigationService.clearStackAndShow(Routes.home);
    }
  }

  void showDialogOnException(error) {
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
