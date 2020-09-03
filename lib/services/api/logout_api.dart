import 'package:injectable/injectable.dart';
import 'package:tnp/services/api/base_api.dart';

@lazySingleton
class LogoutApi extends BaseApi {
  Future<bool> logout(
      int regn, String passw, String email, String token) async {
    Map<String, dynamic> data = {
      'regn': regn.toString(),
      'passw': passw,
      'email': email,
      'token': token,
    };
    Map<String, dynamic> response;
    try {
      response = await post('/logout/', data);
    } catch (error) {
      throw error;
    }
    return response['status'];
  }
}
