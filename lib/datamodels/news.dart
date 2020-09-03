import 'package:intl/intl.dart' show DateFormat;

class News {
  int id;
  String date;
  String title;
  String body;
  String link;

  News.fromMap(Map<String, dynamic> news) {
    id = news['id'];
    date = DateFormat("d MMM yy").format(DateTime.parse(news['date']));
    title = news['title'];
    body = news['body'];
    link = news['link'];
  }
}
