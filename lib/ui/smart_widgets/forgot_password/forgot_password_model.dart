import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/exceptions/bad_request_exception.dart';
import 'package:tnp/exceptions/fetch_data_exception.dart';
import 'package:tnp/exceptions/timeout_exception.dart';
import 'package:tnp/exceptions/unauthorised_exception.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/managers/user_manager.dart';
import 'package:tnp/services/api/forgot_password_api.dart';

class ForgotPasswordModel extends BaseViewModel {
  ForgotPasswordApi _forgotPassword = locator<ForgotPasswordApi>();
  UserManager _userManager = locator<UserManager>();
  DialogService _dialogService = locator<DialogService>();

  void forgotPassword() async {
    DialogResponse _response = await _dialogService.showCustomDialog(
        customData: DialogType.Confirm,
        title: 'Forgot Password',
        description:
            'You password will be sent to your registered Email as well as to alternate Email (if available).',
        mainButtonTitle: 'I Understand',
        secondaryButtonTitle: 'Cancel');
    bool _continue = _response.confirmed;
    if (_continue) {
      bool _success;
      _dialogService.showCustomDialog(
        customData: DialogType.Wait,
        title: 'Requesting...',
      );
      try {
        _success = await _forgotPassword.forgotPassword(_userManager.user);
      } catch (error) {
        _dialogService.completeDialog(DialogResponse());
        _showDialogOnException(error);
      }
      if (_success != null) {
        _dialogService.completeDialog(DialogResponse());
        if (_success) {
          _dialogService.showCustomDialog(
            customData: DialogType.Alert,
            title: 'Sent Successfully',
            description:
                'Email has been sent, please check your Inbox. If you don\'t receive the mail' +
                    ' in next couple of minutes, check the spam folder or try again later.',
          );
        } else {
          _dialogService.showCustomDialog(
            customData: DialogType.Alert,
            title: 'Failed!',
            description: 'Failed to send mail! Try again later or contact us.',
          );
        }
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
