import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:tnp/exceptions/fetch_data_exception.dart';
import 'package:tnp/datamodels/student.dart';
import 'package:tnp/services/api/base_api.dart';
import 'package:http/http.dart' as http;

@lazySingleton
class ProfileUpdateApi extends BaseApi {
  Future<int> updateProfile(Student s) async {
    var response;
    try {
      var postUri = Uri.parse('${BaseApi.endpoint}/update_request/');
      var request = http.MultipartRequest('POST', postUri);
      request.fields['roll'] = s.roll.toString();
      request.fields['regn'] = s.regn.toString();
      request.fields['batch'] = s.batch.toString();
      request.fields['batch'] = s.batch.toString();
      request.fields['admission_year'] = s.admissionYear.toString();
      request.fields['course'] = s.course;
      request.fields['branch'] = s.branch;
      request.fields['current_cgpa'] = s.currentCgpa.toString();
      request.fields['m_tech_specialization'] = s.mtechSpecialization ?? '';
      request.fields['name'] = s.name;
      request.fields['gender'] = s.gender;
      request.fields['dob'] = s.dob;
      request.fields['email'] = s.email;
      request.fields['alternate_email'] = s.alternateEmail ?? '';
      request.fields['phone'] = s.phone;
      request.fields['alternate_phone'] = s.alternatePhone ?? '';
      request.fields['current_backlogs'] = s.currentBacklogs.toString();
      request.fields['tenth_marks'] = s.tenthMarks.toString();
      request.fields['tenth_board'] = s.tenthBoard;
      request.fields['tenth_year'] = s.tenthYear.toString();
      request.fields['twelfth_marks'] = s.twelfthMarks?.toString() ?? '';
      request.fields['twelfth_board'] = s.twelfthBoard ?? '';
      request.fields['twelfth_year'] = s.twelfthYear?.toString() ?? '';
      request.fields['diploma_marks'] = s.diplomaMarks?.toString() ?? '';
      request.fields['diploma_branch'] = s.diplomaBranch ?? '';
      request.fields['diploma_year'] = s.diplomaYear?.toString() ?? '';
      request.fields['graduation_degree'] = s.graduationDegree ?? '';
      request.fields['graduation_branch'] = s.graduationBranch ?? '';
      request.fields['graduation_year'] = s.graduationYear?.toString() ?? '';
      request.fields['graduation_marks'] = s.graduationMarks?.toString() ?? '';
      request.fields['g_university_name'] = s.gUniversityName ?? '';
      request.fields['aadhar'] = s.aadhar;
      request.fields['father_name'] = s.fatherName;
      request.fields['mother_name'] = s.motherName;
      request.fields['category'] = s.category;
      request.fields['present_address'] = s.presentAddress;
      request.fields['present_district'] = s.presentDistrict;
      request.fields['present_city'] = s.presentCity;
      request.fields['present_pin'] = s.presentPin.toString();
      request.fields['permanent_address'] = s.permanentAddress;
      request.fields['permanent_district'] = s.permanentDistrict;
      request.fields['permanent_city'] = s.permanentCity;
      request.fields['permanent_pin'] = s.permanentPin.toString();
      request.fields['history_backlogs'] = s.historyBacklogs?.toString() ?? '';
      request.fields['sgpa_1st'] = s.sgpa1st?.toString() ?? '';
      request.fields['sgpa_2nd'] = s.sgpa2nd?.toString() ?? '';
      request.fields['sgpa_3rd'] = s.sgpa3rd?.toString() ?? '';
      request.fields['sgpa_4th'] = s.sgpa4th?.toString() ?? '';
      request.fields['sgpa_5th'] = s.sgpa5th?.toString() ?? '';
      request.fields['sgpa_6th'] = s.sgpa6th?.toString() ?? '';
      request.fields['sgpa_7th'] = s.sgpa7th?.toString() ?? '';
      request.fields['sgpa_8th'] = s.sgpa8th?.toString() ?? '';
      request.fields['sgpa_9th'] = s.sgpa9th?.toString() ?? '';
      request.fields['sgpa_10th'] = s.sgpa10th?.toString() ?? '';
      request.fields['gen_rank'] = s.genRank;
      request.fields['sc_rank'] = s.scRank ?? '';
      request.fields['st_rank'] = s.stRank ?? '';
      request.fields['green_card_rank'] = s.greenCardRank ?? '';
      request.fields['other_rank'] = s.otherRank ?? '';
      request.fields['honors_3rdsem'] = s.honors3rdsem ?? '';
      request.fields['honors_4thsem'] = s.honors4thsem ?? '';
      request.fields['honors_5thsem'] = s.honors5thsem ?? '';
      request.fields['honors_6thsem'] = s.honors6thsem ?? '';
      request.fields['honors_7thsem'] = s.honors7thsem ?? '';
      request.fields['honors_8thsem'] = s.honors8thsem ?? '';
      request.fields['honors_9thsem'] = s.honors9thsem ?? '';
      request.fields['honors_10thsem'] = s.honors10thsem ?? '';
      if (s.newImage != null) {
        request.files.add(
           http.MultipartFile.fromBytes(
            'file',
            s.newImage,
            filename: s.newImageName,
          ),
        );
      }
      var streamedRes = await request.send();
      var res = await http.Response.fromStream(streamedRes);
      response = returnResponse(res);
    } on SocketException {
      throw FetchDataException("No proper internet connection");
    }catch(error){
      throw error;
    }
    if(response == null) return null;
    return response['status'];
  }
}
