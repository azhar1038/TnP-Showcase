import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:tnp/ui/views/edit_profile_view/edit_profile_view.dart';
import 'package:tnp/ui/views/first_login_view/first_login_view.dart';
import 'package:tnp/ui/views/force_update_view/force_update_view.dart';
import 'package:tnp/ui/views/home_view/home_view.dart';
import 'package:tnp/ui/views/login_link_view/login_link_view.dart';
import 'package:tnp/ui/views/startup_view/startup_view.dart';
import 'package:tnp/ui/views/validate_view/validate_view.dart';
import 'package:tnp/ui/views/inapp_web_view/inapp_web_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(
      page: StartupView,
      initial: true,
      name: 'startup',
      path: '/startup',
    ),
    MaterialRoute(
      page: ValidateView,
      name: 'validateForm',
      path: '/validate',
    ),
    CustomRoute(
      page: FirstLoginView,
      name: 'firstLoginForm',
      path: '/first-login',
      transitionsBuilder: TransitionsBuilders.slideRight,
    ),
    CustomRoute(
      page: LoginLinkView,
      name: 'loginLinkForm',
      path: '/login',
      transitionsBuilder: TransitionsBuilders.slideLeft,
    ),
    MaterialRoute(
      page: EditProfileView,
      name: 'editProfile',
      path: '/edit-profile',
    ),
    MaterialRoute(
      page: InAppWebView,
      name: 'webview',
      path: '/webview',
    ),
    MaterialRoute(
      page: ForceUpdateView,
      name: 'forceUpdate',
      path: '/force-update'
    ),
    MaterialRoute(
      page: HomeView,
      name: 'home',
      path: '/home',
    )
  ],
)
class $Router {}
