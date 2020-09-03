import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/app/router.gr.dart';
import 'package:tnp/datamodels/student.dart';
import 'package:tnp/managers/theme_manager.dart';
import 'package:tnp/managers/user_manager.dart';

class ProfileViewModel extends BaseViewModel {
  UserManager _userManager = locator<UserManager>();
  NavigationService _navigationService = locator<NavigationService>();
  ThemeManager _themeManager = locator<ThemeManager>();

  Student get student => _userManager.user.student;
  ThemeType get theme => _themeManager.theme;

  void navigateToEdit() {
    _navigationService.navigateTo(Routes.editProfile);
  }
}
