import 'package:intl/intl.dart' show DateFormat;

class Notification {
  int id;
  String dateAndTime;
  String subject;
  String content;

  Notification.fromMap(Map<String, dynamic> notification) {
    id = notification['id'];
    dateAndTime = DateFormat("d MMM yy, hh:mm a")
        .format(DateTime.parse(notification['date_and_time']));
    subject = notification['subject'];
    content = notification['content'];
  }
}
