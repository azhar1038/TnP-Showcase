import 'package:injectable/injectable.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/datamodels/news.dart';
import 'package:tnp/services/api/news_api.dart';
import 'package:tnp/services/database_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

@lazySingleton
class NewsManager {
  static List<News> _news;

  Future<List<News>> getNews() async {
    DatabaseService _databaseService;
    NewsApi _newsApi;

    if (_news == null) {
      _newsApi = locator<NewsApi>();
      int id=0;
      List<News> news = [];
      if(!kIsWeb) {
        List<Map<String, dynamic>> localNews;
        _databaseService = locator<DatabaseService>();
        try {
          localNews =
          await _databaseService.queryAllRows(DatabaseService.NewsTable);
        } catch (error) {
          throw error;
        }
        if (localNews != null && localNews.length > 0) {
          id = localNews.last['id'];
          localNews.forEach((n) {
            news.add(News.fromMap(n));
          });
        }
        localNews = [];
      }
      List<dynamic> fetchedNews;
      try {
        fetchedNews = await _newsApi.getNews(id);
      } catch (error) {
        throw error;
      }
      if (fetchedNews.length > 0 && fetchedNews != null) {
        fetchedNews.forEach((n) {
          news.add(News.fromMap(n));
        });
        if(!kIsWeb) {
          _databaseService
              .insert(DatabaseService.NewsTable, fetchedNews)
              .then((_) {
            fetchedNews.clear();
          }).catchError((error) {
            throw error;
          });
        }
      }
      _news = news.reversed.toList();
    }
    return _news;
  }

  void dispose() => _news = null;
}
