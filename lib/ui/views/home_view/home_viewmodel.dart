import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/app/router.gr.dart';
import 'package:tnp/managers/theme_manager.dart';
import 'package:tnp/ui/views/news_view/news_view.dart';
import 'package:tnp/ui/views/notification_view/notification_view.dart';
import 'package:tnp/ui/views/profile_view/profile_view.dart';
import 'package:tnp/ui/views/settings_view/settings_view.dart';

class HomeViewModel extends IndexTrackingViewModel {
  ThemeManager _themeManager = locator<ThemeManager>();
  NavigationService _navigationService = locator<NavigationService>();

  void reloadTheme() => _themeManager.changeTheme(_themeManager.theme);

  Widget getPage(int index){
    switch(index){
      case 0:
        return NotificationView();
      case 1:
        return NewsView();
      case 2:
        return ProfileView();
      case 3:
        return SettingsView();
      default:
        return NotificationView();
    }
  }

  void navigateToEdit() {
    _navigationService.navigateTo(Routes.editProfile);
  }

  String getTitle(int index){
    switch(index){
      case 0:
        return 'Notification';
      case 1:
        return 'News';
      case 2:
        return 'Profile';
      case 3:
        return 'Settings';
      default:
        return 'Training & Placement Cell';
    }
  }
}
