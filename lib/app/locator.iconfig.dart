// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:tnp/services/database_service.dart';
import 'package:tnp/services/third_party_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tnp/services/fcm_service.dart';
import 'package:tnp/services/file_service.dart';
import 'package:tnp/services/api/forgot_password_api.dart';
import 'package:tnp/services/image_pick_service.dart';
import 'package:tnp/services/inapp_update_service.dart';
import 'package:tnp/services/api/login_api.dart';
import 'package:tnp/services/api/logout_api.dart';
import 'package:tnp/services/api/news_api.dart';
import 'package:tnp/managers/news_manager.dart';
import 'package:tnp/services/api/notification_api.dart';
import 'package:tnp/managers/notification_manager.dart';
import 'package:tnp/services/package_info_service.dart';
import 'package:tnp/services/api/profile_update_api.dart';
import 'package:tnp/services/shared_pref_service.dart';
import 'package:tnp/managers/theme_manager.dart';
import 'package:tnp/services/url_launch_service.dart';
import 'package:tnp/managers/user_manager.dart';
import 'package:get_it/get_it.dart';

Future<void> $initGetIt(GetIt g, {String environment}) async {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<ForgotPasswordApi>(() => ForgotPasswordApi());
  g.registerLazySingleton<ImagePickService>(() => ImagePickService());
  g.registerLazySingleton<LoginApi>(() => LoginApi());
  g.registerLazySingleton<LogoutApi>(() => LogoutApi());
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  g.registerLazySingleton<NewsApi>(() => NewsApi());
  g.registerLazySingleton<NewsManager>(() => NewsManager());
  g.registerLazySingleton<NotificationApi>(() => NotificationApi());
  g.registerLazySingleton<NotificationManager>(() => NotificationManager());
  g.registerLazySingleton<ProfileUpdateApi>(() => ProfileUpdateApi());
  g.registerLazySingleton<UrlLaunchService>(() => UrlLaunchService());
  g.registerLazySingleton<UserManager>(() => UserManager());

  //Register android Dependencies --------
  if (environment == 'android') {
    g.registerLazySingleton<FCMService>(() => FCMService());
    g.registerLazySingleton<InAppUpdateService>(() => InAppUpdateService());
  }

  //Eager singletons must be registered in the right order
  if (environment == 'android') {
    final databaseService = await DatabaseService.getInstance();
    g.registerSingleton<DatabaseService>(databaseService);
    final fileService = await FileService.getInstance();
    g.registerSingleton<FileService>(fileService);
    final packageInfoService = await PackageInfoService.getInstance();
    g.registerSingleton<PackageInfoService>(packageInfoService);
  }
  final sharedPrefService = await SharedPrefService.getInstance();
  g.registerSingleton<SharedPrefService>(sharedPrefService);
  g.registerSingleton<ThemeManager>(ThemeManager());
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
}
