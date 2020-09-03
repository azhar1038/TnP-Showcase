import 'package:injectable/injectable.dart';
import 'package:package_info/package_info.dart';
import 'package:tnp/app/constants.dart';

@android
@preResolve
@singleton
class PackageInfoService {
  static PackageInfoService _instance;
  static PackageInfo _packageInfo;

  @factoryMethod
  static Future<PackageInfoService> getInstance() async {
    if (_instance == null) _instance = PackageInfoService();
    if (_packageInfo == null) _packageInfo = await PackageInfo.fromPlatform();
    return _instance;
  }

  String get appVersion => _packageInfo.version;
}
