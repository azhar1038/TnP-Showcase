import 'package:tnp/datamodels/student.dart';

class User{
  int regn;
  String name;
  String email;
  String passw;
  String token;
  Student student;

  User({this.email, this.passw, this.regn});

  User.initialUser(){
    this.regn = 0;
    this.name = "Unknown";
    this.email = '';
    this.passw = '';
    this.token = '';
    this.student = null;
  }

  User.fromJson(Map<String, dynamic> json){
    regn = json['regn']??0;
    name = null;
    email = json['email']??'';
    passw = json['passw']??'';
    token = json['token']??'';
    student = null;
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> user = {
      'regn':this.regn,
      'email':this.email,
      'passw':this.passw,
      'token':this.token,
    };
    return user;
  }
}