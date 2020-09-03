import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/exceptions/bad_request_exception.dart';
import 'package:tnp/exceptions/fetch_data_exception.dart';
import 'package:tnp/exceptions/timeout_exception.dart';
import 'package:tnp/exceptions/unauthorised_exception.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/datamodels/student.dart';
import 'package:tnp/managers/user_manager.dart';
import 'package:tnp/services/api/profile_update_api.dart';

class EditProfileViewModel extends IndexTrackingViewModel {
  UserManager _userManager = locator<UserManager>();
  DialogService _dialogService = locator<DialogService>();
  ProfileUpdateApi _profileUpdateApi = locator<ProfileUpdateApi>();
  NavigationService _navigationService = locator<NavigationService>();

  Student _newStudent;

  Student get student => _newStudent;

  void initializeStudent() async {
    setBusy(true);
    Student savedStudent;
    if (!kIsWeb) savedStudent = await _userManager.loadFromFile();
    if (savedStudent != null) {
      DialogResponse dRes = await _dialogService.showCustomDialog(
        customData: DialogType.Confirm,
        title: 'Load Saved Data?',
        description:
            'Unsubmitted form data was found. You can either load that form or start again.' +
                '\n\nIMPORTANT: Changes in profile picture wasn\'t stored. So if you had changed your' +
                ' profile picture, make sure to change it again.',
        mainButtonTitle: 'Load',
        secondaryButtonTitle: 'Start Again',
      );
      if (dRes.confirmed)
        _newStudent = savedStudent;
      else {
        _newStudent = Student.copyFrom(_userManager.student);
        _userManager.deleteLocalFile();
      }
    } else
      _newStudent = Student.copyFrom(_userManager.student);
    setBusy(false);
  }

  String get title {
    switch (currentIndex) {
      case 0:
        return 'Edit Profile';
      case 1:
        return 'Edit Personal Details';
      case 2:
        return 'Edit Course Details';
      case 3:
        return 'Edit Academic Details';
      case 4:
        return 'Edit 12th Details';
      case 5:
        return 'Edit 10th Details';
      case 6:
        return 'Edit Diploma Details';
      case 7:
        return 'Edit Graduation Details';
      case 8:
        return 'Edit Profile';
      default:
        return 'Edit Profile';
    }
  }

  Future<bool> onPop() async {
    if (currentIndex > 0) {
      DialogResponse dRes = await _dialogService.showCustomDialog(
        customData: DialogType.Confirm,
        title: 'Are you Sure?',
        description: kIsWeb
            ? 'This form has some unsubmitted data. If you go back, your data will be lost. Would you still like to go back?'
            : 'All the filled section details have been saved locally and can be loaded back later. Would you like to go back?',
      );
      return dRes.confirmed;
    }
    return true;
  }

  void onNext() {
    if(!kIsWeb){
      if (currentIndex != 0) _userManager.saveToFile(_newStudent);
    }
    if (currentIndex < 8) setIndex(currentIndex + 1);
  }

  void onPrevious() {
    if (currentIndex > 0) setIndex(currentIndex - 1);
  }

  void onSubmit() async {
    _dialogService.showCustomDialog(
      customData: DialogType.Wait,
      title: 'Requesting Update...',
    );
    int response;
    try {
      response = await _profileUpdateApi.updateProfile(_newStudent);
    } catch (error) {
      showDialogOnException(error);
    }
    _dialogService.completeDialog(DialogResponse());
    if (response != null) {
      if (response == 1) {
        _userManager.deleteLocalFile();
        await _dialogService.showCustomDialog(
          customData: DialogType.Alert,
          title: 'Success',
          description: 'Request has been sent successfully.',
        );
        _navigationService.back();
      } else if (response == 0) {
        await _dialogService.showCustomDialog(
          customData: DialogType.Alert,
          title: 'Error',
          description: 'Failed to request. Try again later.',
        );
      } else if (response == 2) {
        await _dialogService.showCustomDialog(
          customData: DialogType.Alert,
          title: 'Have Patience',
          description:
              'You already have a pending request. Wait until it has been verified.',
        );
        _navigationService.back();
      }
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
