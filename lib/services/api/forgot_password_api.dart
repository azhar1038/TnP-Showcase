import 'package:injectable/injectable.dart';
import 'package:tnp/datamodels/user.dart';
import 'package:tnp/services/api/login_api.dart';

@lazySingleton
class ForgotPasswordApi extends LoginApi {
  Future<bool> forgotPassword(User user) async {
    Map<String, dynamic> response;
    try {
      response = await post("/forgot_password/", {
        "email": user.email,
        "regn": user.regn.toString(),
      });
      if (response['status'] == 1)
        return true;
      else
        return false;
    } catch (error) {
      throw error;
    }
  }
}
