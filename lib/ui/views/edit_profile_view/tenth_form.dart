import 'package:flutter/material.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/datamodels/student.dart';
import 'package:tnp/ui/widgets/centered.dart';
import 'package:tnp/ui/widgets/form_input_field.dart';

class TenthForm extends StatefulWidget {
  final VoidCallback onNext, onPrevious;
  final Student student;

  const TenthForm({
    Key key,
    @required this.onNext,
    @required this.onPrevious,
    @required this.student,
  }) : super(key: key);

  @override
  _TenthFormState createState() => _TenthFormState();
}

class _TenthFormState extends State<TenthForm> {
  GlobalKey<FormState> _formKey;
  Student _student;
  FocusNode _firstError;

  // 10th Details
  TextEditingController _board10, _year10, _marks10;
  FocusNode _board10Focus, _year10Focus, _marks10Focus;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _student = widget.student;
    // 10th Details
    _board10 = TextEditingController(text: _student.tenthBoard);
    _year10 = TextEditingController(text: _student.tenthYear.toString());
    _marks10 = TextEditingController(text: _student.tenthMarks.toString());

    _board10Focus = FocusNode();
    _year10Focus = FocusNode();
    _marks10Focus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _board10.dispose();
    _year10.dispose();
    _marks10.dispose();

    _board10Focus.dispose();
    _year10Focus.dispose();
    _marks10Focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        key: PageStorageKey('tenth_form_page_key'),
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
                    '10th Details',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _board10,
                    focusNode: _board10Focus,
                    keyboardType: TextInputType.text,
                    labelText: '10th Board',
                    validator: (String s) {
                      String e;
                      if (s.isEmpty) e = "Board cannot be empty";
                      if (e != null && _firstError == null)
                        _firstError = _board10Focus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _year10Focus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _year10,
                    focusNode: _year10Focus,
                    keyboardType: TextInputType.number,
                    labelText: '10th Passing Year',
                    validator: (String s) {
                      String e;
                      if (s.isEmpty) e = "Year cannot be empty";
                      try {
                        int n = int.parse(s);
                        if (n <= 1950 || n >= DateTime.now().year)
                          e = "Invalid Year";
                      } catch (er) {
                        e = "Enter a valid year";
                      }
                      if (e != null && _firstError == null)
                        _firstError = _year10Focus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _marks10Focus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _marks10,
                    focusNode: _marks10Focus,
                    keyboardType: TextInputType.number,
                    labelText: '10th Marks (in %)',
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
                      if (s.isEmpty) e = "Marks cannot be empty";
                      try {
                        double m = double.parse(s);
                        if (m <= 0 || m > 100) e = "Enter marks in %";
                      } catch (er) {
                        e = "Invalid marks";
                      }
                      if (e != null && _firstError == null)
                        _firstError = _marks10Focus;
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
    _student.tenthBoard = _board10.text;
    _student.tenthYear = int.parse(_year10.text);
    _student.tenthMarks = double.parse(_marks10.text);
  }
}
