import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tnp/exceptions/bad_request_exception.dart';
import 'package:tnp/exceptions/fetch_data_exception.dart';
import 'package:tnp/exceptions/unauthorised_exception.dart';

class BaseApi {
  static const String endpoint = "https://your.path.to.api";

  http.Client client = http.Client();

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await client.get(endpoint + url);
//      .timeout(Duration(seconds: 5), onTimeout: () => throw TimeoutException());
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No proper internet connection");
    }
    return responseJson;
  }

  Future<dynamic> post(String url, Map<String, dynamic> data) async {
    var responseJson;
    try {
      final response = await client.post(endpoint+url, body: data);
//      .timeout(Duration(seconds: 5), onTimeout: () => throw TimeoutException());
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No proper internet connection");
    }
    return responseJson;
  }

//  Future<dynamic> multipart(String url, Map<String, String> fields,
//      {String fieldName, String filePath}) async {
//    var responseJson;
//    try {
//      var postUri = Uri.parse(endpoint + url);
//      var request = http.MultipartRequest('POST', postUri);
//      fields.forEach((key, value) => request.fields[key] = value);
//      if (filePath.isNotEmpty) {
//        request.files.add(await http.MultipartFile.fromPath(
//            fieldName, filePath,
//            filename: filePath.split('/').last)
//        );
//      }
//      var streamedRes = await request.send();
////      .timeout(Duration(seconds: 5), onTimeout: () => throw TimeoutException());
//      var response = await http.Response.fromStream(streamedRes);
//      responseJson = returnResponse(response);
//    } on SocketException {
//      throw FetchDataException("No proper internet connection");
//    }
//    return responseJson;
//  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body);
      case 401:
      case 403:
        throw UnauthorisedException(response.body);
      case 500:
      default:
        throw FetchDataException(
            "Error in communicating with Server with StatusCode: ${response
                .statusCode}");
    }
  }
}