import 'package:injectable/injectable.dart';
import 'package:tnp/datamodels/user.dart';
import 'package:tnp/services/api/base_api.dart';
//import 'package:flutter/foundation.dart' show kIsWeb;

@lazySingleton
class LoginApi extends BaseApi {
  Future<Map<String, dynamic>> validateUser(User user) async {
    Map<String, dynamic> response;
    try {
//      if (kIsWeb)
//        response = {'stud_name': 'Testing Student', 'first_login': false, 'valid':true};
//      else
      response = await get("/validate/?regn=${user.regn}&email=${user.email}");
    } catch (error) {
      throw error;
    }
    return response;
  }

  Future<Map<String, dynamic>> firstLogin(User user) async {
    Map<String, dynamic> data, response;
    data = {
      'regn': user.regn.toString(),
      'passw': user.passw,
      'email': user.email,
    };
    try {
      response = await post("/first_login/", data);
    } catch (error) {
      throw error;
    }
    return response;
  }

  Future<Map<String, dynamic>> loginAndLinkDevice(
      User user, bool newToken) async {
    Map<String, dynamic> data, response;
    data = {
      'regn': user.regn.toString(),
      'passw': user.passw,
      'email': user.email,
    };
    if (newToken) data['token'] = user.token;
    try {
//      if (!kIsWeb)
        response = await post("/login_and_link_device/", data);
//      else
//        response = {
//          'status': true,
//          'student': {
//            'id': 1,
//            'roll': 12345,
//            'regn': 1729904567,
//            'batch': 2021,
//            'image': null,
//            'admission_year': 2017,
//            'course': 'Bachelors',
//            'branch': 'Computer Science',
//            'current_cgpa': 8.0,
//            'm_tech_specialization': null,
//            'name': 'Testing Student',
//            'gender': 'male',
//            'dob': '2012-12-12',
//            'email': 'test@gmail.com',
//            'alternate_email': null,
//            'phone': '2673844098',
//            'alternate_phone': null,
//            'current_backlogs': 0,
//            'tenth_marks': 80.5,
//            'tenth_board': 'CBSE',
//            'tenth_year': 2015,
//            'twelfth_marks': 80.7,
//            'twelfth_board': 'CHSE',
//            'twelfth_year': 2017,
//            'placed': false,
//            'diploma_marks': null,
//            'diploma_branch': null,
//            'diploma_year': null,
//            'graduation_degree': null,
//            'graduation_branch': null,
//            'graduation_year': null,
//            'graduation_marks': null,
//            'g_university_name': null,
//            'aadhar': '999999999999',
//            'father_name': 'mm',
//            'mother_name': 'nn',
//            'category': 'GEN',
//            'present_address': 'aa',
//            'present_district': 'aas',
//            'present_city': 'jdj',
//            'present_pin': 999999,
//            'permanent_address': 'ff',
//            'permanent_district': 'dd',
//            'permanent_city': 'ss',
//            'permanent_pin': 777777,
//            'history_backlogs': 0,
//            'sgpa_1st': null,
//            'sgpa_2nd': null,
//            'sgpa_3rd': null,
//            'sgpa_4th': null,
//            'sgpa_5th': null,
//            'sgpa_6th': null,
//            'sgpa_7th': null,
//            'sgpa_8th': null,
//            'sgpa_9th': null,
//            'sgpa_10th': null,
//            'gen_rank': '78689',
//            'sc_rank': null,
//            'st_rank': null,
//            'green_card_rank': null,
//            'other_rank': null,
//            'honors_3rdsem': null,
//            'honors_4thsem': null,
//            'honors_5thsem': null,
//            'honors_6thsem': null,
//            'honors_7thsem': null,
//            'honors_8thsem': null,
//            'honors_9thsem': null,
//            'honors_10thsem': null,
//          }
//        };
    } catch (error) {
      throw error;
    }
    return response;
  }

  Future<Map<String, dynamic>> logout(User user) async {
    Map<String, dynamic> data, response;
    data = {
      'regn': user.regn.toString(),
      'passw': user.passw,
      'email': user.email,
      'token': user.token,
    };
    try {
      response = await post("/logout/", data);
    } catch (error) {
      throw error;
    }
    return response;
  }
}
