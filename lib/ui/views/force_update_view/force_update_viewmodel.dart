import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/managers/theme_manager.dart';
import 'package:tnp/services/inapp_update_service.dart';
import 'package:tnp/services/url_launch_service.dart';

class ForceUpdateViewModel extends BaseViewModel {
  InAppUpdateService _inAppUpdate = locator<InAppUpdateService>();
  ThemeManager _themeManager = locator<ThemeManager>();
  DialogService _dialogService = locator<DialogService>();
  UrlLaunchService _urlLaunch = locator<UrlLaunchService>();

  void reloadTheme() => _themeManager.changeTheme(_themeManager.theme);

  void forceUpdate() async {
    bool update = await _inAppUpdate.checkForUpdate();
    if (update)
      _inAppUpdate.forceUpdate().catchError((e) {
        notifyListeners();
        _dialogService.showCustomDialog(
          customData: DialogType.Alert,
          title: 'Failed to update.',
          description:
              'Something went wrong. Try again later or use the Play store to update manually.',
        );
      });
  }

  void openPlayStore() => _urlLaunch.launchUrl(appPlaystoreLink);
}
