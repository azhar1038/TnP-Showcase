import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/datamodels/student.dart';
import 'package:tnp/ui/widgets/centered.dart';
import 'package:tnp/ui/widgets/form_input_field.dart';

class AcademicForm extends StatefulWidget {
  final VoidCallback onNext, onPrevious;
  final Student student;

  const AcademicForm({
    Key key,
    @required this.onNext,
    @required this.onPrevious,
    @required this.student,
  }) : super(key: key);

  @override
  _AcademicFormState createState() => _AcademicFormState();
}

class _AcademicFormState extends State<AcademicForm> {
  GlobalKey<FormState> _formKey;
  Student _student;
  FocusNode _firstError;

  // Academic Details
  TextEditingController _cgpa, _backlogs, _historyBacklogs;
  TextEditingController _sgpa1st, _sgpa2nd, _sgpa3rd, _sgpa4th, _sgpa5th;
  TextEditingController _sgpa6th, _sgpa7th, _sgpa8th, _sgpa9th, _sgpa10th;
  TextEditingController _honors3, _honors4, _honors5, _honors6;
  TextEditingController _honors7, _honors8, _honors9, _honors10;
  TextEditingController _genRank, _scRank, _stRank, _greenRank, _otherRank;

  FocusNode _cgpaFocus, _backlogsFocus, _historyBacklogsFocus;
  FocusNode _sgpa1stFocus, _sgpa2ndFocus, _sgpa3rdFocus, _sgpa4thFocus;
  FocusNode _sgpa5thFocus, _sgpa6thFocus, _sgpa7thFocus, _sgpa8thFocus;
  FocusNode _sgpa9thFocus, _sgpa10thFocus, _otherRankFocus;
  FocusNode _honors3Focus, _honors4Focus, _honors5Focus, _honors6Focus;
  FocusNode _honors7Focus, _honors8Focus, _honors9Focus, _honors10Focus;
  FocusNode _genRankFocus, _scRankFocus, _stRankFocus, _greenRankFocus;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _student = widget.student;
    // Academic Details
    _cgpa = TextEditingController(text: _student.currentCgpa.toString());
    _backlogs =
        TextEditingController(text: _student.currentBacklogs.toString());
    _historyBacklogs =
        TextEditingController(text: _student.historyBacklogs?.toString() ?? '');

    _sgpa1st = TextEditingController(text: _student.sgpa1st?.toString() ?? '');
    _sgpa2nd = TextEditingController(text: _student.sgpa2nd?.toString() ?? '');
    _sgpa3rd = TextEditingController(text: _student.sgpa3rd?.toString() ?? '');
    _sgpa4th = TextEditingController(text: _student.sgpa4th?.toString() ?? '');
    _sgpa5th = TextEditingController(text: _student.sgpa5th?.toString() ?? '');
    _sgpa6th = TextEditingController(text: _student.sgpa6th?.toString() ?? '');
    _sgpa7th = TextEditingController(text: _student.sgpa7th?.toString() ?? '');
    _sgpa8th = TextEditingController(text: _student.sgpa8th?.toString() ?? '');
    _sgpa9th = TextEditingController(text: _student.sgpa9th?.toString() ?? '');
    _sgpa10th =
        TextEditingController(text: _student.sgpa10th?.toString() ?? '');

    _honors3 = TextEditingController(text: _student.honors3rdsem ?? '');
    _honors4 = TextEditingController(text: _student.honors4thsem ?? '');
    _honors5 = TextEditingController(text: _student.honors5thsem ?? '');
    _honors6 = TextEditingController(text: _student.honors6thsem ?? '');
    _honors7 = TextEditingController(text: _student.honors7thsem ?? '');
    _honors8 = TextEditingController(text: _student.honors8thsem ?? '');
    _honors9 = TextEditingController(text: _student.honors9thsem ?? '');
    _honors10 = TextEditingController(text: _student.honors10thsem ?? '');

    _genRank = TextEditingController(text: _student.genRank ?? '');
    _scRank = TextEditingController(text: _student.scRank ?? '');
    _stRank = TextEditingController(text: _student.stRank ?? '');
    _greenRank = TextEditingController(text: _student.greenCardRank ?? '');
    _otherRank = TextEditingController(text: _student.otherRank ?? '');

    //Focus Nodes
    _cgpaFocus = FocusNode();
    _backlogsFocus = FocusNode();
    _historyBacklogsFocus = FocusNode();
    _sgpa1stFocus = FocusNode();
    _sgpa2ndFocus = FocusNode();
    _sgpa3rdFocus = FocusNode();
    _sgpa4thFocus = FocusNode();
    _sgpa5thFocus = FocusNode();
    _sgpa6thFocus = FocusNode();
    _sgpa7thFocus = FocusNode();
    _sgpa8thFocus = FocusNode();
    _sgpa9thFocus = FocusNode();
    _sgpa10thFocus = FocusNode();
    _otherRankFocus = FocusNode();
    _honors3Focus = FocusNode();
    _honors4Focus = FocusNode();
    _honors5Focus = FocusNode();
    _honors6Focus = FocusNode();
    _honors7Focus = FocusNode();
    _honors8Focus = FocusNode();
    _honors9Focus = FocusNode();
    _honors10Focus = FocusNode();
    _genRankFocus = FocusNode();
    _scRankFocus = FocusNode();
    _stRankFocus = FocusNode();
    _greenRankFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    //TextEditingControllers
    _cgpa.dispose();
    _backlogs.dispose();
    _historyBacklogs.dispose();
    _sgpa1st.dispose();
    _sgpa2nd.dispose();
    _sgpa3rd.dispose();
    _sgpa4th.dispose();
    _sgpa5th.dispose();
    _sgpa6th.dispose();
    _sgpa7th.dispose();
    _sgpa8th.dispose();
    _sgpa9th.dispose();
    _sgpa10th.dispose();
    _genRank.dispose();
    _scRank.dispose();
    _stRank.dispose();
    _greenRank.dispose();
    _otherRank.dispose();

    //FocusNodes
    _cgpaFocus.dispose();
    _backlogsFocus.dispose();
    _historyBacklogsFocus.dispose();
    _sgpa1stFocus.dispose();
    _sgpa2ndFocus.dispose();
    _sgpa3rdFocus.dispose();
    _sgpa4thFocus.dispose();
    _sgpa5thFocus.dispose();
    _sgpa6thFocus.dispose();
    _sgpa7thFocus.dispose();
    _sgpa8thFocus.dispose();
    _sgpa9thFocus.dispose();
    _sgpa10thFocus.dispose();
    _otherRankFocus.dispose();
    _honors3Focus.dispose();
    _honors4Focus.dispose();
    _honors5Focus.dispose();
    _honors6Focus.dispose();
    _honors7Focus.dispose();
    _honors8Focus.dispose();
    _honors9Focus.dispose();
    _honors10Focus.dispose();
    _genRankFocus.dispose();
    _scRankFocus.dispose();
    _stRankFocus.dispose();
    _greenRankFocus.dispose();

    super.dispose();
  }

  Widget getSgpaFormRow(
    TextEditingController controller1,
    TextEditingController controller2,
    String label1,
    String label2,
    FocusNode focus1,
    FocusNode focus2,
    FocusNode focus3,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: FormInputField(
              controller: controller1,
              focusNode: focus1,
              keyboardType: TextInputType.number,
              labelText: label1,
              inputFormatters: [
//                WhitelistingTextInputFormatter(RegExp(r"[0-9+.]")),
                FilteringTextInputFormatter.allow(RegExp(r"[0-9+.]")),
              ],
              validator: (String s) {
                String e;
                if (s.isNotEmpty)
                  try {
                    double n = double.parse(s);
                    if (n < 0 || n > 10) e = "Range is 0-10";
                  } catch (er) {
                    e = "Invalid value";
                  }
                if (e != null && _firstError == null) _firstError = focus1;
                return e;
              },
              onFieldSubmitted: (s) => focus2.requestFocus(),
            ),
          ),
          SizedBox(width: 12),
          Flexible(
            child: FormInputField(
              controller: controller2,
              focusNode: focus2,
              keyboardType: TextInputType.number,
              labelText: label2,
              inputFormatters: [
//                WhitelistingTextInputFormatter(RegExp(r"[0-9+.]")),
              FilteringTextInputFormatter.allow(RegExp(r"[0-9+.]")),
              ],
              validator: (String s) {
                String e;
                if (s.isNotEmpty)
                  try {
                    double n = double.parse(s);
                    if (n < 0 || n > 10) e = "Range is 0-10";
                  } catch (er) {
                    e = "Invalid value";
                  }
                if (e != null && _firstError == null) _firstError = focus2;
                return e;
              },
              onFieldSubmitted: (s) => focus3.requestFocus(),
            ),
          ),
        ],
      ),
    );
  }

  Widget getHonorsFormField(
    TextEditingController controller,
    String label,
    FocusNode focus,
    FocusNode nextFocus,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: FormInputField(
        controller: controller,
        focusNode: focus,
        keyboardType: TextInputType.text,
        labelText: label,
        onFieldSubmitted: (s) => nextFocus.requestFocus(),
      ),
    );
  }

  Widget getRankFormField(
    TextEditingController controller,
    String label,
    FocusNode focus,
    FocusNode nextFocus,
  ) {
    return Flexible(
      child: FormInputField(
        controller: controller,
        focusNode: focus,
        keyboardType: TextInputType.number,
        labelText: label,
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        validator: (String s) {
          String e;
          if (s.isNotEmpty)
            try {
              int n = int.parse(s);
              if (n <= 0) e = "Invalid rank";
            } catch (er) {
              e = "Invalid rank";
            }
          if (e != null && _firstError == null) _firstError = focus;
          return null;
        },
        onFieldSubmitted: (s) {
          if (nextFocus != null)
            nextFocus.requestFocus();
          else
            _onSubmit();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        key: PageStorageKey('academic_form_page_key'),
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
                    'Academic Details',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _backlogs,
                    focusNode: _backlogsFocus,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    labelText: 'Current no. of Backlogs',
                    validator: (String s) {
                      String e;
                      if (s.isEmpty) e = "Backlogs cannot be empty";
                      if (e != null && _firstError == null)
                        _firstError = _backlogsFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) =>
                        _historyBacklogsFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _historyBacklogs,
                    focusNode: _historyBacklogsFocus,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    labelText: 'Total no. of Backlogs',
                    validator: (String s) {
                      String e;
                      if (s.isEmpty) e = "Backlogs cannot be empty";
                      if (e != null && _firstError == null)
                        _firstError = _historyBacklogsFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _cgpaFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _cgpa,
                    focusNode: _cgpaFocus,
                    keyboardType: TextInputType.number,
                    labelText: 'Current CGPA',
                    inputFormatters: [
//                      WhitelistingTextInputFormatter(RegExp(r"[0-9+.]")),
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9+.]")),
                    ],
                    validator: (String s) {
                      String e;
                      if (s.isEmpty) e = "Cannot be empty";
                      try {
                        double n = double.parse(s);
                        if (n < 0 || n > 10) e = "Should lie between 0 & 10";
                      } catch (er) {
                        e = "Invalid value";
                      }
                      if (e != null && _firstError == null)
                        _firstError = _cgpaFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _sgpa1stFocus.requestFocus(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'All Semester SGPA',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                getSgpaFormRow(_sgpa1st, _sgpa2nd, '1st Sem', '2nd Sem',
                    _sgpa1stFocus, _sgpa2ndFocus, _sgpa3rdFocus),
                getSgpaFormRow(_sgpa3rd, _sgpa4th, '3rd Sem', '4th Sem',
                    _sgpa3rdFocus, _sgpa4thFocus, _sgpa5thFocus),
                getSgpaFormRow(_sgpa5th, _sgpa6th, '5th Sem', '6th Sem',
                    _sgpa5thFocus, _sgpa6thFocus, _sgpa7thFocus),
                getSgpaFormRow(_sgpa7th, _sgpa8th, '7th Sem', '8th Sem',
                    _sgpa7thFocus, _sgpa8thFocus, _sgpa9thFocus),
                getSgpaFormRow(_sgpa9th, _sgpa10th, '9th Sem', '10th Sem',
                    _sgpa9thFocus, _sgpa10thFocus, _honors3Focus),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Honors Subject\n(Fill if applicable)',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                getHonorsFormField(
                    _honors3, 'Honors 3rd Sem', _honors3Focus, _honors4Focus),
                getHonorsFormField(
                    _honors4, 'Honors 4th Sem', _honors4Focus, _honors5Focus),
                getHonorsFormField(
                    _honors5, 'Honors 5th Sem', _honors5Focus, _honors6Focus),
                getHonorsFormField(
                    _honors6, 'Honors 6th Sem', _honors6Focus, _honors7Focus),
                getHonorsFormField(
                    _honors7, 'Honors 7th Sem', _honors7Focus, _honors8Focus),
                getHonorsFormField(
                    _honors8, 'Honors 8th Sem', _honors8Focus, _honors9Focus),
                getHonorsFormField(
                    _honors9, 'Honors 9th Sem', _honors9Focus, _honors10Focus),
                getHonorsFormField(_honors10, 'Honors 10th Sem', _honors10Focus,
                    _genRankFocus),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'JEE/OJEE Rank\n(Fill only the applicable fields)',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: FormInputField(
                    controller: _genRank,
                    focusNode: _genRankFocus,
                    keyboardType: TextInputType.number,
                    labelText: 'General',
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    validator: (String s) {
                      String e;
                      if (s.isEmpty) e = "Rank cannot be Empty";
                      try {
                        double n = double.parse(s);
                        if (n <= 0) e = "Invalid rank";
                      } catch (er) {
                        e = "Invalid rank";
                      }
                      if (e != null && _firstError == null)
                        _firstError = _genRankFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _scRankFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      getRankFormField(
                          _scRank, 'SC (opt.)', _scRankFocus, _stRankFocus),
                      SizedBox(width: 16),
                      getRankFormField(
                          _stRank, 'ST (opt.)', _stRankFocus, _greenRankFocus),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      getRankFormField(_greenRank, 'Green Card (opt.)',
                          _greenRankFocus, _otherRankFocus),
                      SizedBox(width: 16),
                      getRankFormField(
                          _otherRank, 'Other (opt.)', _otherRankFocus, null),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
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
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _onSubmit();
                            widget.onNext();
                          }
                        },
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
    _student.currentCgpa = double.parse(_cgpa.text);
    _student.currentBacklogs = int.parse(_backlogs.text);
    _student.historyBacklogs = int.parse(_historyBacklogs.text);
    _student.sgpa1st =
        _sgpa1st.text.isEmpty ? null : double.parse(_sgpa1st.text);
    _student.sgpa2nd =
        _sgpa2nd.text.isEmpty ? null : double.parse(_sgpa2nd.text);
    _student.sgpa3rd =
        _sgpa3rd.text.isEmpty ? null : double.parse(_sgpa3rd.text);
    _student.sgpa4th =
        _sgpa4th.text.isEmpty ? null : double.parse(_sgpa4th.text);
    _student.sgpa5th =
        _sgpa5th.text.isEmpty ? null : double.parse(_sgpa5th.text);
    _student.sgpa6th =
        _sgpa6th.text.isEmpty ? null : double.parse(_sgpa6th.text);
    _student.sgpa7th =
        _sgpa7th.text.isEmpty ? null : double.parse(_sgpa7th.text);
    _student.sgpa8th =
        _sgpa8th.text.isEmpty ? null : double.parse(_sgpa8th.text);
    _student.sgpa9th =
        _sgpa9th.text.isEmpty ? null : double.parse(_sgpa9th.text);
    _student.sgpa10th =
        _sgpa10th.text.isEmpty ? null : double.parse(_sgpa10th.text);

    _student.honors3rdsem = _honors3.text.isEmpty ? null : _honors3.text;
    _student.honors4thsem = _honors4.text.isEmpty ? null : _honors4.text;
    _student.honors5thsem = _honors5.text.isEmpty ? null : _honors5.text;
    _student.honors6thsem = _honors6.text.isEmpty ? null : _honors6.text;
    _student.honors7thsem = _honors7.text.isEmpty ? null : _honors7.text;
    _student.honors8thsem = _honors8.text.isEmpty ? null : _honors8.text;
    _student.honors9thsem = _honors9.text.isEmpty ? null : _honors9.text;
    _student.honors10thsem = _honors10.text.isEmpty ? null : _honors10.text;

    _student.genRank = _genRank.text;
    _student.scRank = _scRank.text.isEmpty ? null : _scRank.text;
    _student.stRank = _stRank.text.isEmpty ? null : _stRank.text;
    _student.greenCardRank = _greenRank.text.isEmpty ? null : _greenRank.text;
    _student.otherRank = _otherRank.text.isEmpty ? null : _otherRank.text;
  }
}
