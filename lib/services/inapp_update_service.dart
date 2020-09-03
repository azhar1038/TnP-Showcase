import 'package:in_app_update/in_app_update.dart';
import 'package:injectable/injectable.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/exceptions/inapp_update_exception.dart';

@android
@lazySingleton
class InAppUpdateService {
  Future<bool> checkForUpdate() async {
    return InAppUpdate.checkForUpdate().then((info) {
      if (info?.updateAvailable == true) return true;
      return false;
    }).catchError((e) {
      print(e);
      return false;
    });
  }

  Future<void> forceUpdate() {
    return InAppUpdate.performImmediateUpdate().catchError((error) {
      return Future.error(
        InAppUpdateException(
            "Play store in-app update service failed unexpectedly."),
      );
    });
  }
}
