import 'package:injectable/injectable.dart';
import 'package:tnp/services/api/base_api.dart';
//import 'package:flutter/foundation.dart' show kIsWeb;

@lazySingleton
class NewsApi extends BaseApi {
  Future<List<dynamic>> getNews(int id) async {
    List<dynamic> response;
    try {
//      if(!kIsWeb)
      response = await get('/fetch_news/?id=$id');
//      else
//        response = [
//          {
//            'id':1,
//            'date':'2019-12-16',
//            'title':'News Title 1',
//            'body': 'Testing News Body',
//            'link':null,
//          },
//          {
//            'id':2,
//            'date':'2019-12-16',
//            'title':'News Title 2',
//            'body': 'Testing News Body\n.\n.\n.\n.\nMultiline',
//            'link':null,
//          },
//          {
//            'id':3,
//            'date':'2019-12-16',
//            'title':'News Title 3',
//            'body': 'Testing News Body',
//            'link':"https://google.com",
//          },
//        ];
      return response;
    } catch (error) {
      throw error;
    }
  }
}
