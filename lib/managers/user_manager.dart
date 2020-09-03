import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/datamodels/student.dart';
import 'package:tnp/datamodels/user.dart';
import 'package:tnp/services/file_service.dart';

@lazySingleton
class UserManager {
  static User _user;
  static const String StudentFile = "partialForm.json";
  static FileService _fileService;
  static File _file;

  User get user {
    if (_user == null) _user = User.initialUser();
    return _user;
  }

  File _getFile(){
    if(_file == null){
      _fileService = locator<FileService>();
      _file = _fileService.getFile(StudentFile);
    }
    return _file;
  }

  set user(User user) => _user = user;

  Student get student => _user.student;

  Future<Student> loadFromFile() async {
    File file = _getFile();
    if(await file.exists()){
      var json = jsonDecode(await file.readAsString());
      return Student.fromMap(json);
    }
    return null;
  }

  void saveToFile(Student newStudent) {
    File file = _getFile();
    file.writeAsString(jsonEncode(newStudent.toJson()));
  }

  void deleteLocalFile(){
    File file = _getFile();
    file.delete(recursive: false);
  }
}
