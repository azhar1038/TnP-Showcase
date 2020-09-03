import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/ui/views/profile_view/profile_viewmodel.dart';
import 'package:tnp/ui/widgets/centered.dart';
import 'package:tnp/ui/widgets/expansion_card.dart';
import 'package:tnp/ui/widgets/fade_in.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  ProfileViewModel _model;

  Widget getHeader(String title) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget getRow(String title, String value, {MaterialColor color}) {
    Color c = Theme.of(context).textTheme.bodyText2.color;
    if (color != null) {
      if (_model.theme == ThemeType.Light)
        c = color;
      else
        c = color[200];
    }
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 16),
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyText2.copyWith(color: c),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.nonReactive(
        onModelReady: (model) => _model = model,
        builder: (context, model, child) {
          Widget profileImage = Container(
            padding: EdgeInsets.all(16),
            child: Centered(
              maxWidth: maxWidth,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: Theme.of(context).textTheme.headline6.color),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/profile.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                        Container(
                          child: model.student.image != null
                              ? Image.network(
                                  'https://home.igitplacements.ac.in/media/${model.student.image}',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    return progress == null
                                        ? child
                                        : Center(
                                            child: CircularProgressIndicator(),
                                          );
                                  },
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(model.student.name,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6),
                    ),
                  ),
                ],
              ),
            ),
          );

          Widget personalInfo = Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Centered(
              maxWidth: maxWidth,
              child: ExpansionCard(
                header: getHeader('Personal Details'),
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    getRow('Email', model.student.email),
                    model.student.alternateEmail != null
                        ? getRow(
                            'Alternate Email', model.student.alternateEmail)
                        : Container(),
                    getRow('DoB', model.student.dob),
                    getRow('Gender', model.student.gender),
                    getRow('Phone', model.student.phone),
                    model.student.alternatePhone != null
                        ? getRow(
                            'Alternate Phone', model.student.alternatePhone)
                        : Container(),
                    getRow('Aadhar', model.student.aadhar ?? 'N/A'),
                    getRow('Father\'s Name', model.student.fatherName ?? 'N/A'),
                    getRow('Mother\'s Name', model.student.motherName ?? 'N/A'),
                    getRow('Category', model.student.category ?? 'N/A'),
                  ],
                ),
              ),
            ),
          );

          Widget permanentAddressInfo = Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Centered(
              maxWidth: maxWidth,
              child: ExpansionCard(
                header: getHeader('Permanent Address'),
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    getRow('Address', model.student.permanentAddress ?? 'N/A'),
                    getRow(
                        'District', model.student.permanentDistrict ?? 'N/A'),
                    getRow('City', model.student.permanentCity ?? 'N/A'),
                    getRow(
                        'Pin', model.student.permanentPin?.toString() ?? 'N/A'),
                  ],
                ),
              ),
            ),
          );

          Widget presentAddressInfo = Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Centered(
              maxWidth: maxWidth,
              child: ExpansionCard(
                header: getHeader('Present Address'),
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    getRow('Address', model.student.presentAddress ?? 'N/A'),
                    getRow('District', model.student.presentDistrict ?? 'N/A'),
                    getRow('City', model.student.presentCity ?? 'N/A'),
                    getRow(
                        'Pin', model.student.presentPin?.toString() ?? 'N/A'),
                  ],
                ),
              ),
            ),
          );

          Widget courseDetails = Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Centered(
              maxWidth: maxWidth,
              child: ExpansionCard(
                header: getHeader('Course Details'),
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    getRow('Roll No', model.student.roll.toString()),
                    getRow('Regn No', model.student.regn.toString()),
                    getRow('Branch', model.student.branch),
                    getRow('Course', model.student.course),
                    getRow('Year of Admission',
                        model.student.admissionYear?.toString() ?? 'N/A'),
                    getRow('Year of Completion',
                        model.student.batch?.toString() ?? 'N/A'),
                    model.student.mtechSpecialization != null
                        ? getRow('Specialization',
                            model.student.mtechSpecialization ?? '')
                        : Container(),
                  ],
                ),
              ),
            ),
          );

          Widget academicDetails = Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Centered(
              maxWidth: maxWidth,
              child: ExpansionCard(
                isExpanded: true,
                header: getHeader('Academic Details'),
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    getRow('CGPA', model.student.currentCgpa.toString()),
                    model.student.sgpa1st != null
                        ? getRow('SGPA Sem 1', model.student.sgpa1st.toString())
                        : Container(),
                    model.student.sgpa2nd != null
                        ? getRow('SGPA Sem 2', model.student.sgpa2nd.toString())
                        : Container(),
                    model.student.sgpa3rd != null
                        ? getRow('SGPA Sem 3', model.student.sgpa3rd.toString())
                        : Container(),
                    model.student.sgpa4th != null
                        ? getRow('SGPA Sem 4', model.student.sgpa4th.toString())
                        : Container(),
                    model.student.sgpa5th != null
                        ? getRow('SGPA Sem 5', model.student.sgpa5th.toString())
                        : Container(),
                    model.student.sgpa6th != null
                        ? getRow('SGPA Sem 6', model.student.sgpa6th.toString())
                        : Container(),
                    model.student.sgpa7th != null
                        ? getRow('SGPA Sem 7', model.student.sgpa7th.toString())
                        : Container(),
                    model.student.sgpa8th != null
                        ? getRow('SGPA Sem 8', model.student.sgpa8th.toString())
                        : Container(),
                    model.student.sgpa9th != null
                        ? getRow('SGPA Sem 9', model.student.sgpa9th.toString())
                        : Container(),
                    model.student.sgpa10th != null
                        ? getRow(
                            'SGPA Sem 10', model.student.sgpa10th.toString())
                        : Container(),
                    model.student.honors3rdsem != null
                        ? getRow('Honors Sem 3', model.student.honors3rdsem)
                        : Container(),
                    model.student.honors4thsem != null
                        ? getRow('Honors Sem 4', model.student.honors4thsem)
                        : Container(),
                    model.student.honors5thsem != null
                        ? getRow('Honors Sem 5', model.student.honors5thsem)
                        : Container(),
                    model.student.honors6thsem != null
                        ? getRow('Honors Sem 6', model.student.honors6thsem)
                        : Container(),
                    model.student.honors7thsem != null
                        ? getRow('Honors Sem 7', model.student.honors7thsem)
                        : Container(),
                    model.student.honors8thsem != null
                        ? getRow('Honors Sem 8', model.student.honors8thsem)
                        : Container(),
                    model.student.honors9thsem != null
                        ? getRow('Honors Sem 9', model.student.honors9thsem)
                        : Container(),
                    model.student.honors10thsem != null
                        ? getRow('Honors Sem 10', model.student.honors10thsem)
                        : Container(),
                    getRow(
                      'Backlogs (Currently)',
                      model.student.currentBacklogs.toString(),
                      color: model.student.currentBacklogs > 0
                          ? Colors.red
                          : Colors.green,
                    ),
                    getRow('Backlogs (Total)',
                        model.student.historyBacklogs?.toString() ?? 'N/A'),
                    getRow(
                      'Placed',
                      model.student.placed ? 'Yes' : 'No',
                      color: model.student.placed ? Colors.green : Colors.red,
                    ),
                    getRow('General Rank', model.student.genRank ?? 'N/A'),
                    model.student.scRank != null
                        ? getRow('SC Rank', model.student.scRank)
                        : Container(),
                    model.student.stRank != null
                        ? getRow('ST Rank', model.student.stRank)
                        : Container(),
                    model.student.greenCardRank != null
                        ? getRow('Green Card Rank', model.student.greenCardRank)
                        : Container(),
                    model.student.otherRank != null
                        ? getRow('Other Rank', model.student.otherRank)
                        : Container(),
                  ],
                ),
              ),
            ),
          );

          Widget graduationDetails = Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Centered(
              maxWidth: maxWidth,
              child: ExpansionCard(
                header: getHeader('Graduation Details'),
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    getRow('Degree', model.student.graduationDegree ?? ''),
                    getRow('Branch', model.student.graduationBranch ?? ''),
                    getRow(
                        'Year', model.student.graduationYear?.toString() ?? ''),
                    getRow('Marks',
                        model.student.graduationMarks?.toString() ?? ''),
                    getRow('University', model.student.gUniversityName ?? ''),
                  ],
                ),
              ),
            ),
          );

          Widget diplomaDetails = Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Centered(
              maxWidth: maxWidth,
              child: ExpansionCard(
                header: getHeader('Diploma Details'),
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    getRow('Branch', model.student.diplomaBranch ?? ''),
                    getRow('Year', model.student.diplomaYear?.toString() ?? ''),
                    getRow(
                        'Marks', model.student.diplomaMarks?.toString() ?? ''),
                  ],
                ),
              ),
            ),
          );

          Widget twelfthDetails = Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Centered(
              maxWidth: maxWidth,
              child: ExpansionCard(
                header: getHeader('12th Details'),
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    getRow('Board', model.student.twelfthBoard ?? ''),
                    getRow('Year', model.student.twelfthYear?.toString() ?? ''),
                    getRow(
                        'Marks', model.student.twelfthMarks?.toString() ?? ''),
                  ],
                ),
              ),
            ),
          );

          Widget tenthDetails = Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Centered(
              maxWidth: maxWidth,
              child: ExpansionCard(
                header: getHeader('10th Details'),
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    getRow('Board', model.student.tenthBoard ?? ''),
                    getRow('Year', model.student.tenthYear?.toString() ?? ''),
                    getRow('Marks', model.student.tenthMarks?.toString() ?? ''),
                  ],
                ),
              ),
            ),
          );

          return FadeIn(
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.only(bottom: 48),
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  profileImage,
                  academicDetails,
                  personalInfo,
                  permanentAddressInfo,
                  presentAddressInfo,
                  courseDetails,
                  model.student.graduationYear != null
                      ? graduationDetails
                      : Container(),
                  model.student.diplomaYear != null
                      ? diplomaDetails
                      : Container(),
                  model.student.twelfthYear != null
                      ? twelfthDetails
                      : Container(),
                  tenthDetails,
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => ProfileViewModel());
  }
}
