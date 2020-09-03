import 'package:flutter/material.dart' hide Router;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/app/router.gr.dart';
import 'package:tnp/app/theme_data.dart';
import 'package:tnp/managers/theme_manager.dart';
import 'package:tnp/services/shared_pref_service.dart';

import 'app/enums.dart';

class TnP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<_TnPModel>.reactive(
      onModelReady: (model) => model.loadTheme(),
      builder: (context, model, child) {
        return MaterialApp(
          title: 'T&P App',
          theme: appTheme[model.theme],
          initialRoute: Routes.startup,
          onGenerateRoute: Router(),
          navigatorKey: model.navigatorKey,
        );
      },
      viewModelBuilder: () => _TnPModel(),
    );
  }
}

class _TnPModel extends StreamViewModel<ThemeType>{
  ThemeManager _themeManager = locator<ThemeManager>();
  SharedPrefService _storage = locator<SharedPrefService>();
  NavigationService _navigator = locator<NavigationService>();
  ThemeType get theme => data;
  dynamic get navigatorKey => _navigator.navigatorKey;

  void loadTheme(){
    _themeManager.changeTheme(_storage.theme);
  }

  @override
  Stream<ThemeType> get stream => _themeManager.themeStream;

}