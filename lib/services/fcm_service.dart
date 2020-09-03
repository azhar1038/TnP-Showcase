import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:tnp/app/constants.dart';

@android
@lazySingleton
class FCMService{
  Future<String> getNewToken(String oldToken) async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    String newToken = await _firebaseMessaging.getToken();
    if(oldToken != newToken){
      print('NEW TOKEN FOUND');
      return newToken;
    }else{
      return null;
    }
  }
}