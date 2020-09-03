// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:tnp/ui/views/startup_view/startup_view.dart';
import 'package:tnp/ui/views/validate_view/validate_view.dart';
import 'package:tnp/ui/views/first_login_view/first_login_view.dart';
import 'package:tnp/ui/views/login_link_view/login_link_view.dart';
import 'package:tnp/ui/views/edit_profile_view/edit_profile_view.dart';
import 'package:tnp/ui/views/inapp_web_view/inapp_web_view.dart';
import 'package:tnp/ui/views/force_update_view/force_update_view.dart';
import 'package:tnp/ui/views/home_view/home_view.dart';

class Routes {
  static const String startup = '/startup';
  static const String validateForm = '/validate';
  static const String firstLoginForm = '/first-login';
  static const String loginLinkForm = '/login';
  static const String editProfile = '/edit-profile';
  static const String webview = '/webview';
  static const String forceUpdate = '/force-update';
  static const String home = '/home';
  static const all = <String>{
    startup,
    validateForm,
    firstLoginForm,
    loginLinkForm,
    editProfile,
    webview,
    forceUpdate,
    home,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startup, page: StartupView),
    RouteDef(Routes.validateForm, page: ValidateView),
    RouteDef(Routes.firstLoginForm, page: FirstLoginView),
    RouteDef(Routes.loginLinkForm, page: LoginLinkView),
    RouteDef(Routes.editProfile, page: EditProfileView),
    RouteDef(Routes.webview, page: InAppWebView),
    RouteDef(Routes.forceUpdate, page: ForceUpdateView),
    RouteDef(Routes.home, page: HomeView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    StartupView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartupView(),
        settings: data,
      );
    },
    ValidateView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ValidateView(),
        settings: data,
      );
    },
    FirstLoginView: (RouteData data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            FirstLoginView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideRight,
      );
    },
    LoginLinkView: (RouteData data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            LoginLinkView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideLeft,
      );
    },
    EditProfileView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EditProfileView(),
        settings: data,
      );
    },
    InAppWebView: (RouteData data) {
      var args = data.getArgs<InAppWebViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => InAppWebView(
          key: args.key,
          title: args.title,
          link: args.link,
        ),
        settings: data,
      );
    },
    ForceUpdateView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ForceUpdateView(),
        settings: data,
      );
    },
    HomeView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
  };
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//InAppWebView arguments holder class
class InAppWebViewArguments {
  final Key key;
  final String title;
  final String link;
  InAppWebViewArguments({this.key, @required this.title, @required this.link});
}
