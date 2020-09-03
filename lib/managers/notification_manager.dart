import 'package:injectable/injectable.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/datamodels/notification.dart';
import 'package:tnp/services/api/notification_api.dart';
import 'package:tnp/services/database_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

@lazySingleton
class NotificationManager {
  static List<Notification> _notifications;

  Future<List<Notification>> getNotifications(
      int batch, String branch, String course, bool placement) async {
    DatabaseService _databaseService;
    NotificationApi _notificationApi;
    if (_notifications == null) {
      List<Notification> notifications = [];
      _notificationApi = locator<NotificationApi>();
      int id = 0;
      if (!kIsWeb) {
        _databaseService = locator<DatabaseService>();
        List<Map<String, dynamic>> localNoti;
        try {
          localNoti = await _databaseService
              .queryAllRows(DatabaseService.NotificationTable);
        } catch (error) {
          throw error;
        }
        if (localNoti != null && localNoti.length > 0) {
          id = localNoti.last['id'];
          localNoti.forEach((n) {
            notifications.add(Notification.fromMap(n));
          });
        }
        localNoti = [];
      }
      List<dynamic> res;
      try {
        res = await _notificationApi.getNotifications(id);
      } catch (error) {
        throw error;
      }
      List<Map<String, dynamic>> newNoti = [];
      for (int i = 0; i < res.length; i++) {
        Map<String, dynamic> n = res[i];
        if ((n['batch'] == null || n['batch'] == '' || n['batch'] == batch) &&
            (n['branch'] == null ||
                n['branch'] == '' ||
                n['branch'] == branch) &&
            (n['course'] == null ||
                n['course'] == '' ||
                n['course'] == course) &&
            (n['placement'] == null ||
                n['placement'] == '' ||
                n['placement'] == placement)) {
          Map<String, dynamic> m = {
            'id': n['id'],
            'date_and_time': n['date_and_time'],
            'subject': n['subject'],
            'content': n['content']
          };
          newNoti.add(m);
        }
      }
      res.clear();
      if (newNoti.length > 0 && newNoti != null) {
        newNoti.forEach((n) {
          notifications.add(Notification.fromMap(n));
        });
        if(!kIsWeb) {
          _databaseService
              .insert(DatabaseService.NotificationTable, newNoti)
              .then((_) {
            newNoti.clear();
          }).catchError((error) {
            throw error;
          });
        }
      }
      _notifications = notifications.reversed.toList();
    }
    return _notifications;
  }

  void dispose() => _notifications = null;
}
