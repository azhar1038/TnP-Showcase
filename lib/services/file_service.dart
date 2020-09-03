import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tnp/app/constants.dart';

@android
@preResolve
@singleton
class FileService {
  static FileService _instance;
  static String _path;

  @factoryMethod
  static Future<FileService> getInstance() async {
    if (_instance == null) _instance = FileService();
    if (_path == null) _path = (await getApplicationDocumentsDirectory()).path;
    return _instance;
  }

  File getFile(String fileName){
    return File("$_path/$fileName");
  }
}