import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/datamodels/student.dart';
import 'package:tnp/ui/widgets/centered.dart';
import 'package:tnp/ui/widgets/dropdown_form_field.dart';
import 'package:tnp/ui/widgets/form_input_field.dart';

class CourseForm extends StatefulWidget {
  final VoidCallback onNext, onPrevious;
  final Student student;

  const CourseForm({
    Key key,
    @required this.onNext,
    @required this.onPrevious,
    @required this.student,
  }) : super(key: key);

  @override
  _CourseFormState createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
  GlobalKey<FormState> _formKey;
  Student _student;
  FocusNode _firstError;

  // Course Details
  TextEditingController _roll, _regn, _branch, _course;
  TextEditingController _batch, _mTechSpec, _admissionYear;

  FocusNode _rollFocus, _batchFocus, _mTechSpecFocus, _admissionYearFocus;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _student = widget.student;
    // Course Details
    _roll = TextEditingController(text: _student.roll.toString());
    _regn = TextEditingController(text: _student.regn.toString());
    _branch = TextEditingController(text: _student.branch);
    _course = TextEditingController(text: _student.course);
    _batch = TextEditingController(text: _student.batch.toString());
    _admissionYear =
        TextEditingController(text: _student.admissionYear?.toString() ?? '');
    _mTechSpec =
        TextEditingController(text: _student.mtechSpecialization ?? '');

    //Focus Node
    _rollFocus = FocusNode();
    _batchFocus = FocusNode();
    _mTechSpecFocus = FocusNode();
    _admissionYearFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    //TextEditingControllers
    _roll.dispose();
    _regn.dispose();
    _branch.dispose();
    _course.dispose();
    _batch.dispose();
    _admissionYear.dispose();
    _mTechSpec.dispose();

    //FocusNodes
    _rollFocus.dispose();
    _batchFocus.dispose();
    _mTechSpecFocus.dispose();
    _admissionYearFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        key: PageStorageKey('course_form_page_key'),
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Centered(
            maxWidth: maxWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 48, bottom: 32),
                  alignment: Alignment.center,
                  child: Text('Course Details',
                      style: Theme.of(context).textTheme.headline5),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _roll,
                    focusNode: _rollFocus,
                    keyboardType: TextInputType.number,
                    labelText: 'Roll',
                    validator: (String s) {
                      String e;
                      if (s.isEmpty) e = "Roll number cannot be empty";
                      if (e != null && _firstError == null)
                        _firstError = _rollFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _admissionYearFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _regn,
                    enabled: false,
                    keyboardType: TextInputType.number,
                    labelText: 'Registration (Cannot be changed)',
                    validator: (String s) {
                      if (s.isEmpty)
                        return "Registration number cannot be empty";
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: DropdownFormField(
                    items: [
                      'Applied Chemistry',
                      'Applied Mathematics',
                      'Applied Physics',
                      'Architecture',
                      'Chemical',
                      'Civil',
                      'Computer Science',
                      'Computer Applications',
                      'Electrical',
                      'Electronics & Telecommunications',
                      'Mechanical',
                      'Metallurgical',
                      'Production',
                    ],
                    controller: _branch,
                    title: 'Branch',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: DropdownFormField(
                    items: ['Bachelors', 'Diploma', 'Masters'],
                    controller: _course,
                    title: 'Course',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _admissionYear,
                    focusNode: _admissionYearFocus,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4)
                    ],
                    labelText: 'Year of Admission',
                    validator: (s) {
                      String e;
                      if (s.isEmpty) e = 'Year of Admission cannot be empty';
                      try {
                        int year = int.parse(s);
                        if (year < 1940 || year > 2080) e = "Invalid year";
                      } catch (er) {
                        e = "Invalid Year";
                      }
                      if (e != null && _firstError == null)
                        _firstError = _admissionYearFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _batchFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _batch,
                    focusNode: _batchFocus,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4)
                    ],
                    labelText: 'Year of Completion',
                    validator: (s) {
                      String e;
                      if (s.isEmpty) e = 'Year of Completion cannot be empty';
                      try {
                        int year = int.parse(s);
                        if (year < 1940 || year > 2080) e = "Invalid year";
                      } catch (er) {
                        e = "Invalid Year";
                      }
                      if (e != null && _firstError == null)
                        _firstError = _batchFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _mTechSpecFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _mTechSpec,
                    focusNode: _mTechSpecFocus,
                    keyboardType: TextInputType.text,
                    labelText: 'Specialization (M.Tech Only)',
                    onFieldSubmitted: (s) => _onSubmit(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Previous'),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _updateStudent();
                            widget.onPrevious();
                          }
                        },
                      ),
                      RaisedButton(
                        child: Text('Next'),
                        onPressed: _onSubmit,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    _firstError = null;
    if (_formKey.currentState.validate()) {
      _updateStudent();
      widget.onNext();
    } else if (_firstError != null) _firstError.requestFocus();
  }

  void _updateStudent() {
    _student.roll = int.parse(_roll.text);
    _student.regn = int.parse(_regn.text);
    _student.branch = _branch.text;
    _student.course = _course.text;
    _student.batch = int.parse(_batch.text);
    _student.admissionYear = int.parse(_admissionYear.text);
    _student.mtechSpecialization =
        _mTechSpec.text.isEmpty ? null : _mTechSpec.text;
  }
}
