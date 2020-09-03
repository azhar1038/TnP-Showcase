import 'package:stacked/stacked.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/services/url_launch_service.dart';

class SignUpModel extends BaseViewModel {
  UrlLaunchService _urlLaunch = locator<UrlLaunchService>();

  void launchRegister() => _urlLaunch.launchUrl(registerLink);
}
