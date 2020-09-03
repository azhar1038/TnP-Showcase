import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/exceptions/bad_request_exception.dart';
import 'package:tnp/exceptions/fetch_data_exception.dart';
import 'package:tnp/exceptions/timeout_exception.dart';
import 'package:tnp/exceptions/unauthorised_exception.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/app/router.gr.dart';
import 'package:tnp/datamodels/user.dart';
import 'package:tnp/managers/theme_manager.dart';
import 'package:tnp/managers/user_manager.dart';
import 'package:tnp/services/api/login_api.dart';

class ValidateFormModel extends BaseViewModel {
  LoginApi _loginApi = locator<LoginApi>();
  UserManager _userManager = locator<UserManager>();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();
  ThemeManager _themeManager = locator<ThemeManager>();
  bool _error = false;

  void reloadTheme() => _themeManager.changeTheme(_themeManager.theme);

  Future<void> validate(String regn, String email) async {
    Map<String, dynamic> response;
    User _user = _userManager.user;
    _user.regn = int.parse(regn);
    _user.email = email;
    setBusy(true);
    _dialogService.showCustomDialog(
      customData: DialogType.Wait,
      title: 'Validating...',
    );
    try {
      response = await _loginApi.validateUser(_user);
    } catch (error) {
      _error = true;
      _showDialogOnException(error);
    }
    setBusy(false);
    _dialogService.completeDialog(DialogResponse());
    if (!_error) {
      if (response['valid']) {
        _user.name = response['stud_name'];
        if (response['first_login']) {
          _navigationService.replaceWith(Routes.firstLoginForm);
        } else {
          _navigationService.replaceWith(Routes.loginLinkForm);
        }
      } else {
        await _dialogService.showCustomDialog(
          customData: DialogType.Alert,
          title: 'Validation Failed!',
          description:
              "Either your Regn. or Email are incorrect or you haven't registered yet.",
        );
      }
    }
  }

  String validateRegn(String s){
    if (s.isEmpty) return "Registration no. cannot be empty";
    try{
      int.parse(s);
    }catch(e){
      return "Only digits are allowed";
    }
    return null;
  }

  String validateEmail(String s){
    if (s.isEmpty)
      return "Email cannot be empty";
    else if (!RegExp(
        r"^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$")
        .hasMatch(s)) return "Enter a valid Email Id";
    return null;
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
