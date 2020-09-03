import 'dart:typed_data';

class Student{
  int id;
  int roll;
  int regn;
  int batch;
  int admissionYear;
  String image;
  Uint8List newImage;
  String newImageName;
  String course;
  String branch;
  double currentCgpa;
  String mtechSpecialization;
  String name;
  String gender;
  String dob;
  String email;
  String alternateEmail;
  String phone;
  String alternatePhone;
  int currentBacklogs;
  double tenthMarks;
  String tenthBoard;
  int tenthYear;
  double twelfthMarks;
  String twelfthBoard;
  int twelfthYear;
  double diplomaMarks;
  String diplomaBranch;
  int diplomaYear;
  String graduationDegree;
  String graduationBranch;
  int graduationYear;
  double graduationMarks;
  String gUniversityName;
  bool placed;
  String aadhar;
  String fatherName;
  String motherName;
  String category;
  String presentAddress;
  String presentDistrict;
  String presentCity;
  int presentPin;
  String permanentAddress;
  String permanentDistrict;
  String permanentCity;
  int permanentPin;
  int historyBacklogs;
  double sgpa1st;
  double sgpa2nd;
  double sgpa3rd;
  double sgpa4th;
  double sgpa5th;
  double sgpa6th;
  double sgpa7th;
  double sgpa8th;
  double sgpa9th;
  double sgpa10th;
  String genRank;
  String scRank;
  String stRank;
  String greenCardRank;
  String otherRank;
  String honors3rdsem;
  String honors4thsem;
  String honors5thsem;
  String honors6thsem;
  String honors7thsem;
  String honors8thsem;
  String honors9thsem;
  String honors10thsem;

  Student.fromMap(Map<String, dynamic> m){
    id = m['id'];
    roll = m['roll'];
    regn = m['regn'];
    batch = m['batch'];
    admissionYear = m['admission_year'];
    image = m['image'];
    course = m['course'];
    branch = m['branch'];
    currentCgpa = m['current_cgpa'];
    mtechSpecialization = m['mtech_specialization'];
    name = m['name'];
    gender = m['gender'];
    dob = m['dob'];
    email = m['email'];
    alternateEmail = m['alternate_email'];
    alternatePhone = m['alternate_phone'];
    phone = m['phone'];
    currentBacklogs = m['current_backlogs'];
    tenthMarks = m['tenth_marks'];
    tenthBoard = m['tenth_board'];
    tenthYear = m['tenth_year'];
    twelfthMarks = m['twelfth_marks'];
    twelfthBoard = m['twelfth_board'];
    twelfthYear = m['twelfth_year'];
    diplomaMarks = m['diploma_marks'];
    diplomaBranch = m['diploma_branch'];
    diplomaYear = m['diploma_year'];
    graduationDegree = m['graduation_degree'];
    graduationBranch = m['graduation_branch'];
    graduationYear = m['graduation_year'];
    graduationMarks = m['graduation_marks'];
    gUniversityName = m['g_university_name'];
    placed = m['placed'];
    aadhar = m['aadhar'];
    fatherName = m['father_name'];
    motherName = m['mother_name'];
    category = m['category'];
    presentAddress = m['present_address'];
    presentDistrict = m['present_district'];
    presentCity = m['present_city'];
    presentPin = m['present_pin'];
    permanentAddress = m['permanent_address'];
    permanentDistrict = m['permanent_district'];
    permanentCity = m['permanent_city'];
    permanentPin = m['permanent_pin'];
    historyBacklogs = m['history_backlogs'];
    sgpa1st = m['sgpa_1st'];
    sgpa2nd = m['sgpa_2nd'];
    sgpa3rd = m['sgpa_3rd'];
    sgpa4th = m['sgpa_4th'];
    sgpa5th = m['sgpa_5th'];
    sgpa6th = m['sgpa_6th'];
    sgpa7th = m['sgpa_7th'];
    sgpa8th = m['sgpa_8th'];
    sgpa9th = m['sgpa_9th'];
    sgpa10th = m['sgpa_10th'];
    genRank = m['gen_rank'];
    scRank = m['sc_rank'];
    stRank = m['st_rank'];
    greenCardRank = m['green_card_rank'];
    otherRank = m['other_rank'];
    honors3rdsem = m['honors_3rdsem'];
    honors4thsem = m['honors_4thsem'];
    honors5thsem = m['honors_5thsem'];
    honors6thsem = m['honors_6thsem'];
    honors7thsem = m['honors_7thsem'];
    honors8thsem = m['honors_8thsem'];
    honors9thsem = m['honors_9thsem'];
    honors10thsem = m['honors_10thsem'];
  }

  Student.copyFrom(Student s){
    id = s.id;
    roll = s.roll;
    regn = s.regn;
    batch = s.batch;
    admissionYear = s.admissionYear;
    image = s.image;
    course = s.course;
    branch = s.branch;
    currentCgpa = s.currentCgpa;
    mtechSpecialization = s.mtechSpecialization;
    name = s.name;
    gender = s.gender;
    dob = s.dob;
    email = s.email;
    alternateEmail = s.alternateEmail;
    phone = s.phone;
    alternatePhone = s.alternatePhone;
    currentBacklogs = s.currentBacklogs;
    tenthMarks = s.tenthMarks;
    tenthBoard = s.tenthBoard;
    tenthYear = s.tenthYear;
    twelfthMarks = s.twelfthMarks;
    twelfthBoard = s.twelfthBoard;
    twelfthYear = s.twelfthYear;
    diplomaMarks = s.diplomaMarks;
    diplomaBranch = s.diplomaBranch;
    diplomaYear = s.diplomaYear;
    graduationDegree = s.graduationDegree;
    graduationBranch = s.graduationBranch;
    graduationYear = s.graduationYear;
    graduationMarks = s.graduationMarks;
    gUniversityName = s.gUniversityName;
    placed = s.placed;
    aadhar = s.aadhar;
    fatherName = s.fatherName;
    motherName = s.motherName;
    category = s.category;
    presentAddress = s.presentAddress;
    presentDistrict = s.presentDistrict;
    presentCity = s.presentCity;
    presentPin = s.presentPin;
    permanentAddress = s.permanentAddress;
    permanentDistrict = s.permanentDistrict;
    permanentCity = s.permanentCity;
    permanentPin = s.permanentPin;
    historyBacklogs = s.historyBacklogs;
    sgpa1st = s.sgpa1st;
    sgpa2nd = s.sgpa2nd;
    sgpa3rd = s.sgpa3rd;
    sgpa4th = s.sgpa4th;
    sgpa5th = s.sgpa5th;
    sgpa6th = s.sgpa6th;
    sgpa7th = s.sgpa7th;
    sgpa8th = s.sgpa8th;
    sgpa9th = s.sgpa9th;
    sgpa10th = s.sgpa10th;
    genRank = s.genRank;
    scRank = s.scRank;
    stRank = s.stRank;
    greenCardRank = s.greenCardRank;
    otherRank = s.otherRank;
    honors3rdsem = s.honors3rdsem;
    honors4thsem = s.honors4thsem;
    honors5thsem = s.honors5thsem;
    honors6thsem = s.honors6thsem;
    honors7thsem = s.honors7thsem;
    honors8thsem = s.honors8thsem;
    honors9thsem = s.honors9thsem;
    honors10thsem = s.honors10thsem;
  }

  Map<String, dynamic> toJson(){
    return {
      'roll': roll,
      'regn': regn,
      'batch': batch,
      'image': image,
      'admission_year': admissionYear,
      'course': course,
      'branch': branch,
      'current_cgpa': currentCgpa,
      'm_tech_specialization': mtechSpecialization,
      'name': name,
      'gender': gender,
      'dob': dob,
      'email': email,
      'alternate_email': alternateEmail,
      'phone': phone,
      'alternate_phone': alternatePhone,
      'current_backlogs': currentBacklogs,
      'tenth_marks': tenthMarks,
      'tenth_board': tenthBoard,
      'tenth_year': tenthYear,
      'twelfth_marks': twelfthMarks,
      'twelfth_board': twelfthBoard,
      'twelfth_year': twelfthYear,
      'diploma_marks': diplomaMarks,
      'diploma_branch': diplomaBranch,
      'diploma_year': diplomaYear,
      'graduation_degree': graduationDegree,
      'graduation_branch': graduationBranch,
      'graduation_year': graduationYear,
      'graduation_marks': graduationMarks,
      'g_university_name': gUniversityName,
      'aadhar': aadhar,
      'father_name': fatherName,
      'mother_name': motherName,
      'category': category,
      'present_address': presentAddress,
      'present_district': presentDistrict,
      'present_city': presentCity,
      'present_pin': presentPin,
      'permanent_address': permanentAddress,
      'permanent_district': permanentDistrict,
      'permanent_city': permanentCity,
      'permanent_pin': permanentPin,
      'history_backlogs': historyBacklogs,
      'sgpa_1st': sgpa1st,
      'sgpa_2nd': sgpa2nd,
      'sgpa_3rd': sgpa3rd,
      'sgpa_4th': sgpa4th,
      'sgpa_5th': sgpa5th,
      'sgpa_6th': sgpa6th,
      'sgpa_7th': sgpa7th,
      'sgpa_8th': sgpa8th,
      'sgpa_9th': sgpa9th,
      'sgpa_10th': sgpa10th,
      'gen_rank': genRank,
      'sc_rank': scRank,
      'st_rank': stRank,
      'green_card_rank': greenCardRank,
      'other_rank': otherRank,
      'honors_3rdsem': honors3rdsem,
      'honors_4thsem': honors4thsem,
      'honors_5thsem': honors5thsem,
      'honors_6thsem': honors6thsem,
      'honors_7thsem': honors7thsem,
      'honors_8thsem': honors8thsem,
      'honors_9thsem': honors9thsem,
      'honors_10thsem': honors10thsem,
    };
  }
}
