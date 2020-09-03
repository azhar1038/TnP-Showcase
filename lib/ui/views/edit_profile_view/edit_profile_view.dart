import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tnp/ui/views/edit_profile_view/academic_form.dart';
import 'package:tnp/ui/views/edit_profile_view/course_form.dart';
import 'package:tnp/ui/views/edit_profile_view/diploma_form.dart';
import 'package:tnp/ui/views/edit_profile_view/edit_profile_viewmodel.dart';
import 'package:tnp/ui/views/edit_profile_view/graduation_form.dart';
import 'package:tnp/ui/views/edit_profile_view/intro.dart';
import 'package:tnp/ui/views/edit_profile_view/personal_form.dart';
import 'package:tnp/ui/views/edit_profile_view/submit_form.dart';
import 'package:tnp/ui/views/edit_profile_view/tenth_form.dart';
import 'package:tnp/ui/views/edit_profile_view/twelfth_form.dart';
import 'package:tnp/ui/widgets/indicator_bar.dart';
import 'package:tnp/ui/widgets/loader.dart';
import 'package:tnp/ui/widgets/top_bar.dart';

class EditProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      viewModelBuilder: () => EditProfileViewModel(),
      onModelReady: (model) => model.initializeStudent(),
      builder: (context, model, child) {
        Orientation orientation = MediaQuery.of(context).orientation;
        return WillPopScope(
          onWillPop: model.onPop,
          child: Scaffold(
            appBar: TopBar(
              title: "Edit Profile",
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed:(){
                  model.onPop().then((popOff){
                    if(popOff) Navigator.of(context).pop();
                  });
                },
                tooltip: 'Back',
                splashColor: Colors.transparent,
//              hoverColor: Colors.transparent,
//              focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ),
            bottomNavigationBar: orientation == Orientation.portrait
                ? IndicatorBar(
                    orientation: Orientation.portrait,
                    count: 9,
                    currentIndex: model.currentIndex,
                  )
                : null,
            body: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                orientation == Orientation.landscape
                    ? IndicatorBar(
                        orientation: Orientation.landscape,
                        count: 9,
                        currentIndex: model.currentIndex,
                      )
                    : Container(),
                Expanded(
                  child: model.isBusy
                      ? Center(child: Loader(text: 'Loading'))
                      : getForm(model),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getForm(EditProfileViewModel model) {
    switch (model.currentIndex) {
      case 0:
        return Intro(
          onNext: model.onNext,
        );
      case 1:
        return PersonalForm(
          student: model.student,
          onNext: model.onNext,
          onPrevious: model.onPrevious,
        );
      case 2:
        return CourseForm(
          student: model.student,
          onNext: model.onNext,
          onPrevious: model.onPrevious,
        );
      case 3:
        return AcademicForm(
          student: model.student,
          onNext: model.onNext,
          onPrevious: model.onPrevious,
        );
      case 4:
        return TwelfthForm(
          student: model.student,
          onNext: model.onNext,
          onPrevious: model.onPrevious,
        );
      case 5:
        return TenthForm(
          student: model.student,
          onNext: model.onNext,
          onPrevious: model.onPrevious,
        );
      case 6:
        return DiplomaForm(
          student: model.student,
          onNext: model.onNext,
          onPrevious: model.onPrevious,
        );
      case 7:
        return GraduationForm(
          student: model.student,
          onNext: model.onNext,
          onPrevious: model.onPrevious,
        );
      case 8:
        return SubmitForm(
          onPrevious: model.onPrevious,
          onSubmit: model.onSubmit,
        );
      default:
        return Intro(
          onNext: model.onNext,
        );
    }
  }
}
