import 'package:flutter/material.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/datamodels/student.dart';
import 'package:tnp/ui/widgets/centered.dart';
import 'package:tnp/ui/widgets/form_input_field.dart';

class GraduationForm extends StatefulWidget {
  final VoidCallback onNext, onPrevious;
  final Student student;

  const GraduationForm({
    Key key,
    @required this.onNext,
    @required this.onPrevious,
    @required this.student,
  }) : super(key: key);

  @override
  _GraduationFormState createState() => _GraduationFormState();
}

class _GraduationFormState extends State<GraduationForm> {
  GlobalKey<FormState> _formKey;
  Student _student;
  FocusNode _firstError;

  // Graduation Details
  TextEditingController _degree, _branchGra, _yearGra, _marksGra, _university;

  FocusNode _degreeFocus, _branchFocus, _yearFocus, _marksFocus, _uniFocus;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _student = widget.student;
    // Graduation Details
    _degree = TextEditingController(text: _student.graduationDegree ?? '');
    _branchGra = TextEditingController(text: _student.graduationBranch ?? '');
    _yearGra =
        TextEditingController(text: _student.graduationYear?.toString() ?? '');
    _marksGra =
        TextEditingController(text: _student.graduationMarks?.toString() ?? '');
    _university = TextEditingController(text: _student.gUniversityName ?? '');

    _degreeFocus = FocusNode();
    _branchFocus = FocusNode();
    _yearFocus = FocusNode();
    _marksFocus = FocusNode();
    _uniFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _degree.dispose();
    _branchGra.dispose();
    _yearGra.dispose();
    _marksGra.dispose();
    _university.dispose();

    _degreeFocus.dispose();
    _branchFocus.dispose();
    _yearFocus.dispose();
    _marksFocus.dispose();
    _uniFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        key: PageStorageKey('graduation_form_page_key'),
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
                  child: Text(
                    'Graduation Details\n(Only for Masters & Lateral Students)',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _degree,
                    focusNode: _degreeFocus,
                    keyboardType: TextInputType.text,
                    labelText: 'Graduation Degree',
                    onFieldSubmitted: (s) => _branchFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _branchGra,
                    focusNode: _branchFocus,
                    keyboardType: TextInputType.text,
                    labelText: 'Graduation Branch',
                    onFieldSubmitted: (s) => _yearFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _yearGra,
                    focusNode: _yearFocus,
                    keyboardType: TextInputType.number,
                    labelText: 'Graduation Year',
                    validator: (String s) {
                      String e;
                      if (s.isNotEmpty)
                        try {
                          int n = int.parse(s);
                          if (n <= 1950 || n > DateTime.now().year)
                            e = "Invalid Year";
                        } catch (er) {
                          e = "Enter a valid year";
                        }
                      if (e != null && _firstError == null)
                        _firstError = _yearFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _marksFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _marksGra,
                    focusNode: _marksFocus,
                    keyboardType: TextInputType.number,
                    labelText: 'Graduation Marks (in %)',
                    suffixIcon: Container(
                      padding: EdgeInsets.only(bottom: 4),
                      alignment: Alignment.center,
                      width: 20,
                      child: Text(
                        '%',
                        style: Theme.of(context)
                            .inputDecorationTheme
                            .labelStyle
                            .copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                    ),
                    validator: (String s) {
                      String e;
                      if (s.isNotEmpty)
                        try {
                          double m = double.parse(s);
                          if (m <= 0 || m > 100) e = "Enter marks in %";
                        } catch (er) {
                          e = "Invalid marks";
                        }
                      if (e != null && _firstError == null)
                        _firstError = _marksFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _uniFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _university,
                    focusNode: _uniFocus,
                    keyboardType: TextInputType.text,
                    labelText: 'Graduation University',
                    onFieldSubmitted: (s)=>_onSubmit(),
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
    _student.graduationDegree = _degree.text.isEmpty ? null : _degree.text;
    _student.graduationBranch =
        _branchGra.text.isEmpty ? null : _branchGra.text;
    _student.graduationYear =
        _yearGra.text.isEmpty ? null : int.parse(_yearGra.text);
    _student.graduationMarks =
        _marksGra.text.isEmpty ? null : double.parse(_marksGra.text);
    _student.gUniversityName =
        _university.text.isEmpty ? null : _university.text;
  }
}
