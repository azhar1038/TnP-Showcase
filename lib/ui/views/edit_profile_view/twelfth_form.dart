import 'package:flutter/material.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/datamodels/student.dart';
import 'package:tnp/ui/widgets/centered.dart';
import 'package:tnp/ui/widgets/form_input_field.dart';

class TwelfthForm extends StatefulWidget {
  final VoidCallback onNext, onPrevious;
  final Student student;

  const TwelfthForm({
    Key key,
    @required this.onNext,
    @required this.onPrevious,
    @required this.student,
  }) : super(key: key);

  @override
  _TwelfthFormState createState() => _TwelfthFormState();
}

class _TwelfthFormState extends State<TwelfthForm> {
  GlobalKey<FormState> _formKey;
  Student _student;
  FocusNode _firstError;

  // 12th Details
  TextEditingController _board12, _year12, _marks12;
  FocusNode _board12Focus, _year12Focus, _marks12Focus;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _student = widget.student;
    // 12th Details
    _board12 = TextEditingController(text: _student.twelfthBoard ?? '');
    _year12 =
        TextEditingController(text: _student.twelfthYear?.toString() ?? '');
    _marks12 =
        TextEditingController(text: _student.twelfthMarks?.toString() ?? '');

    _board12Focus = FocusNode();
    _year12Focus = FocusNode();
    _marks12Focus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _board12.dispose();
    _year12.dispose();
    _marks12.dispose();

    _board12Focus.dispose();
    _year12Focus.dispose();
    _marks12Focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        key: PageStorageKey('twelfth_form_page_key'),
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
                    '12th Details',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _board12,
                    focusNode: _board12Focus,
                    keyboardType: TextInputType.text,
                    labelText: '12th Board',
                    onFieldSubmitted: (s) => _year12Focus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _year12,
                    focusNode: _year12Focus,
                    keyboardType: TextInputType.number,
                    labelText: '12th Passing Year',
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
                        _firstError = _year12Focus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _marks12Focus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _marks12,
                    focusNode: _marks12Focus,
                    keyboardType: TextInputType.number,
                    labelText: '12th Marks (in %)',
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
                        _firstError = _marks12Focus;
                      return e;
                    },
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
    _student.twelfthBoard = _board12.text.isEmpty ? null : _board12.text;
    _student.twelfthYear =
        _year12.text.isEmpty ? null : int.parse(_year12.text);
    _student.twelfthMarks =
        _marks12.text.isEmpty ? null : double.parse(_marks12.text);
  }
}
