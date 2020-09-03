import 'package:flutter/material.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/datamodels/student.dart';
import 'package:tnp/ui/widgets/centered.dart';
import 'package:tnp/ui/widgets/form_input_field.dart';

class DiplomaForm extends StatefulWidget {
  final VoidCallback onNext, onPrevious;
  final Student student;

  const DiplomaForm({
    Key key,
    @required this.onNext,
    @required this.onPrevious,
    @required this.student,
  }) : super(key: key);

  @override
  _DiplomaFormState createState() => _DiplomaFormState();
}

class _DiplomaFormState extends State<DiplomaForm> {
  GlobalKey<FormState> _formKey;
  Student _student;
  FocusNode _firstError;

  // Diploma Details
  TextEditingController _branchDip, _yearDip, _marksDip;

  FocusNode _branchDipFocus, _yearDipFocus, _marksDipFocus;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _student = widget.student;
    // Diploma Details
    _branchDip = TextEditingController(text: _student.diplomaBranch ?? '');
    _yearDip =
        TextEditingController(text: _student.diplomaYear?.toString() ?? '');
    _marksDip =
        TextEditingController(text: _student.diplomaMarks?.toString() ?? '');

    _branchDipFocus = FocusNode();
    _yearDipFocus = FocusNode();
    _marksDipFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _branchDip.dispose();
    _yearDip.dispose();
    _marksDip.dispose();

    _branchDipFocus.dispose();
    _yearDipFocus.dispose();
    _marksDipFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        key: PageStorageKey('diploma_form_page_key'),
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
                    'Diploma Details\n(Only for Lateral Entry)',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _branchDip,
                    focusNode: _branchDipFocus,
                    keyboardType: TextInputType.text,
                    labelText: 'Diploma Branch',
                    onFieldSubmitted: (s) => _yearDipFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _yearDip,
                    focusNode: _yearDipFocus,
                    keyboardType: TextInputType.number,
                    labelText: 'Diploma Passing Year',
                    validator: (String s) {
                      String e;
                      if (s.isNotEmpty)
                        try {
                          int n = int.parse(s);
                          if (n <= 1950 || n >= DateTime.now().year)
                            e = "Invalid Year";
                        } catch (er) {
                          e = "Enter a valid year";
                        }
                      if (e != null && _firstError == null)
                        _firstError = _yearDipFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _marksDipFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _marksDip,
                    focusNode: _marksDipFocus,
                    keyboardType: TextInputType.number,
                    labelText: 'Diploma Marks (in %)',
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
                          if (m <= 0 || m > 100) e= "Enter marks in %";
                        } catch (er) {
                          e= "Invalid marks";
                        }
                      if(e!=null && _firstError == null) _firstError = _marksDipFocus;
                      return e;
                    },
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
    _student.diplomaBranch = _branchDip.text.isEmpty ? null : _branchDip.text;
    _student.diplomaYear =
        _yearDip.text.isEmpty ? null : int.parse(_yearDip.text);
    _student.diplomaMarks =
        _marksDip.text.isEmpty ? null : double.parse(_marksDip.text);
  }
}
