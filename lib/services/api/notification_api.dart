import 'package:injectable/injectable.dart';
import 'package:tnp/services/api/base_api.dart';
//import 'package:flutter/foundation.dart' show kIsWeb;

@lazySingleton
class NotificationApi extends BaseApi {
  Future<List<dynamic>> getNotifications(int id) async {
    List<dynamic> response;
    try {
//      if (!kIsWeb)
        response = await get('/fetch_notifications/?id=$id');
//      else
//        response = [
//          {
//            'id': 1,
//            'date_and_time': "2020-03-22T17:39:40.725Z",
//            'subject': 'Test1',
//            'content': 'Notification test content',
//            'batch':null,
//            'branch':null,
//            'placement':null,
//            'course':null
//          },
//          {
//            'id': 2,
//            'date_and_time': "2020-03-22T17:39:40.725Z",
//            'subject': 'Test2',
//            'content': 'Notification test content',
//            'batch':null,
//            'branch':null,
//            'placement':null,
//            'course':null
//          },
//          {
//            'id': 3,
//            'date_and_time': "2020-03-22T17:39:40.725Z",
//            'subject': 'Test3',
//            'content': 'Notification test content',
//            'batch':null,
//            'branch':null,
//            'placement':null,
//            'course':null
//          },
//          {
//            'id': 4,
//            'date_and_time': "2020-03-22T17:39:40.725Z",
//            'subject': 'Test4',
//            'content': 'Notification test content',
//            'batch':null,
//            'branch':null,
//            'placement':null,
//            'course':null
//          },
//          {
//            'id': 5,
//            'date_and_time': "2020-03-22T17:39:40.725Z",
//            'subject': 'Test5',
//            'content': 'Notification test content',
//            'batch':null,
//            'branch':null,
//            'placement':null,
//            'course':null
//          },
//          {
//            'id': 6,
//            'date_and_time': "2020-03-22T17:39:40.725Z",
//            'subject': 'Test6',
//            'content': 'Notification test content',
//            'batch':null,
//            'branch':null,
//            'placement':null,
//            'course':null
//          },
//        ];
      return response;
    } catch (error) {
      throw error;
    }
  }
}
