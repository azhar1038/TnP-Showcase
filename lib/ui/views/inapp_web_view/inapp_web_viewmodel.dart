import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/exceptions/url_launch_exception.dart';
import 'package:tnp/managers/theme_manager.dart';
import 'package:tnp/services/url_launch_service.dart';

class InAppWebViewModel extends BaseViewModel {
  ThemeManager _themeManager = locator<ThemeManager>();
  UrlLaunchService _urlLaunch = locator<UrlLaunchService>();
  DialogService _dialogService = locator<DialogService>();

  void reloadTheme() => _themeManager.changeTheme(_themeManager.theme);
  int _viewIndex = 2;

  int get viewIndex => _viewIndex;
  ThemeType get theme => _themeManager.theme;

  onPageFinished(String url) {
    if (_viewIndex == 2) {
      _viewIndex = 0;
      notifyListeners();
    }
  }

  checkAndLaunchDriveDownload(String url) async {
    if (url.contains('drive') && url.contains('download')) {
      try {
        await _urlLaunch.launchUrl(url);
        _viewIndex = 1;
        notifyListeners();
      } catch (e) {
        print(e);
      }
    }
  }

  launchBrowser(String url) async {
    try {
      bool launched = await _urlLaunch.launchUrl(url);
      print(launched);
    } on UrlLaunchException catch (error) {
      print(error);
      _viewIndex = 1;
      notifyListeners();
      _dialogService.showCustomDialog(
        customData: DialogType.Alert,
        title: 'Failed to launch',
        description: error.message,
      );
    }
  }
}
