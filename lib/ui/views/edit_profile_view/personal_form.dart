import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/datamodels/student.dart';
import 'package:tnp/ui/smart_widgets/image_pick/image_pick.dart';
import 'package:tnp/ui/widgets/centered.dart';
import 'package:tnp/ui/widgets/date_form_field.dart';
import 'package:tnp/ui/widgets/dropdown_form_field.dart';
import 'package:tnp/ui/widgets/form_input_field.dart';

class PersonalForm extends StatefulWidget {
  final VoidCallback onNext, onPrevious;
  final Student student;

  const PersonalForm({
    Key key,
    @required this.onNext,
    @required this.onPrevious,
    @required this.student,
  }) : super(key: key);

  @override
  _PersonalFormState createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {
  GlobalKey<FormState> _formKey;
  Student _student;
  FocusNode _firstError;
  ScrollController _scrollController;

  // Personal Details
  TextEditingController _name, _email, _altEmail, _dob, _phone, _gender;
  TextEditingController _aadhar, _father, _mother, _category, _altPhone;
  TextEditingController _perAddress, _perDistrict, _perCity, _perPin;
  TextEditingController _preAddress, _preDistrict, _preCity, _prePin;

  FocusNode _nameFocus, _emailFocus, _altEmailFocus, _phoneFocus, _aadharFocus;
  FocusNode _fatherFocus, _motherFocus, _altPhoneFocus;
  FocusNode _perAddressFocus, _perDistrictFocus, _perCityFocus, _perPinFocus;
  FocusNode _preAddressFocus, _preDistrictFocus, _preCityFocus, _prePinFocus;

  // Image choice
  Uint8List _newImage;
  String _imageName;
  String _imageError;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _student = widget.student;
    // Personal Details
    _name = TextEditingController(text: _student.name);
    _email = TextEditingController(text: _student.email);
    _altEmail = TextEditingController(text: _student.alternateEmail ?? '');
    _dob = TextEditingController(text: _student.dob);
    _phone = TextEditingController(text: _student.phone);
    _altPhone = TextEditingController(text: _student.alternatePhone ?? '');
    _gender = TextEditingController(text: _student.gender);
    _aadhar = TextEditingController(text: _student.aadhar ?? '');
    _father = TextEditingController(text: _student.fatherName ?? '');
    _mother = TextEditingController(text: _student.motherName ?? '');
    _category = TextEditingController(text: _student.category ?? 'GEN');
    _perAddress = TextEditingController(text: _student.permanentAddress ?? '');
    _perDistrict =
        TextEditingController(text: _student.permanentDistrict ?? '');
    _perCity = TextEditingController(text: _student.permanentCity ?? '');
    _perPin =
        TextEditingController(text: _student.permanentPin?.toString() ?? '');
    _preAddress = TextEditingController(text: _student.presentAddress ?? '');
    _preDistrict = TextEditingController(text: _student.presentDistrict ?? '');
    _preCity = TextEditingController(text: _student.presentCity ?? '');
    _prePin =
        TextEditingController(text: _student.presentPin?.toString() ?? '');

    // FocusNodes
    _nameFocus = FocusNode();
    _emailFocus = FocusNode();
    _altEmailFocus = FocusNode();
    _phoneFocus = FocusNode();
    _aadharFocus = FocusNode();
    _fatherFocus = FocusNode();
    _motherFocus = FocusNode();
    _altPhoneFocus = FocusNode();
    _perAddressFocus = FocusNode();
    _perDistrictFocus = FocusNode();
    _perCityFocus = FocusNode();
    _perPinFocus = FocusNode();
    _preAddressFocus = FocusNode();
    _preDistrictFocus = FocusNode();
    _preCityFocus = FocusNode();
    _prePinFocus = FocusNode();

    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    // TextEditingControllers
    _name.dispose();
    _email.dispose();
    _altEmail.dispose();
    _dob.dispose();
    _phone.dispose();
    _altPhone.dispose();
    _gender.dispose();
    _aadhar.dispose();
    _father.dispose();
    _mother.dispose();
    _category.dispose();
    _perAddress.dispose();
    _perDistrict.dispose();
    _perCity.dispose();
    _perPin.dispose();
    _preAddress.dispose();
    _preDistrict.dispose();
    _preCity.dispose();
    _prePin.dispose();

    //FocusNodes
    _nameFocus.dispose();
    _emailFocus.dispose();
    _altEmailFocus.dispose();
    _phoneFocus.dispose();
    _aadharFocus.dispose();
    _fatherFocus.dispose();
    _motherFocus.dispose();
    _altPhoneFocus.dispose();
    _perAddressFocus.dispose();
    _perDistrictFocus.dispose();
    _perCityFocus.dispose();
    _perPinFocus.dispose();
    _preAddressFocus.dispose();
    _preDistrictFocus.dispose();
    _preCityFocus.dispose();
    _prePinFocus.dispose();

    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        key: PageStorageKey('personal_form_page_key'),
        controller: _scrollController,
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
                    'Personal Details',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Image Upload',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        '(Upload only if you want to change your current image)',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: ImagePick(
                    onPick: (image, name, error) {
                      _newImage = image;
                      _imageName = name;
                      _imageError = error;
                    },
                    onClear: () {
                      _newImage = null;
                      _imageName = null;
                      _imageError = null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your Details',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _name,
                    focusNode: _nameFocus,
                    keyboardType: TextInputType.text,
                    labelText: 'Name',
                    validator: (String s) {
                      String e;
                      if (s.isEmpty) e = "Name cannot be empty";
                      if (e != null && _firstError == null)
                        _firstError = _nameFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _emailFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _email,
                    focusNode: _emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email',
                    validator: (String s) {
                      String e;
                      if (s.isEmpty)
                        e = "Email cannot be empty";
                      else if (!RegExp(
                              r"^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$")
                          .hasMatch(s)) e = "Enter a valid Email Id";
                      if (e != null && _firstError == null)
                        _firstError = _emailFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _altEmailFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _altEmail,
                    focusNode: _altEmailFocus,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Alternate Email(optional)',
                    validator: (String s) {
                      String e;
                      if (s.isNotEmpty &&
                          !RegExp(r"^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$")
                              .hasMatch(s)) e = "Enter a valid Email Id";
                      if (e != null && _firstError == null)
                        _firstError = _altEmailFocus;
                      return e;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: DateFormField(controller: _dob, title: 'DoB'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: DropdownFormField(
                    items: ['male', 'female'],
                    controller: _gender,
                    title: 'Gender',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _phone,
                    focusNode: _phoneFocus,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    labelText: 'Phone',
                    prefixIcon: Container(
                      padding: EdgeInsets.only(bottom: 4),
                      alignment: Alignment.center,
                      width: 20,
                      child: Text(
                        '+91',
                        style: Theme.of(context)
                            .inputDecorationTheme
                            .labelStyle
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    validator: (String s) {
                      String e;
                      if (s.isEmpty)
                        e = "Phone number cannot be empty";
                      else if (s.length != 10)
                        e = "Enter a 10 digit phone number";
                      else
                        try {
                          int.parse(s);
                        } catch (er) {
                          e = 'Please enter a valid phone number';
                        }
                      if (e != null && _firstError == null)
                        _firstError = _phoneFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _altPhoneFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _altPhone,
                    focusNode: _altPhoneFocus,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    labelText: 'Alternate Phone(optional)',
                    prefixIcon: Container(
                      padding: EdgeInsets.only(bottom: 4),
                      alignment: Alignment.center,
                      width: 20,
                      child: Text(
                        '+91',
                        style: Theme.of(context)
                            .inputDecorationTheme
                            .labelStyle
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    validator: (String s) {
                      String e;
                      if (s.isNotEmpty) {
                        if (s.length != 10)
                          e = "Enter a 10 digit phone number";
                        else
                          try {
                            int.parse(s);
                          } catch (er) {
                            e = 'Please enter a valid phone number';
                          }
                        if (e != null && _firstError == null)
                          _firstError = _altPhoneFocus;
                      }
                      return e;
                    },
                    onFieldSubmitted: (s) => _aadharFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _aadhar,
                    focusNode: _aadharFocus,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12),
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    labelText: 'Aadhar',
                    validator: (String s) {
                      String e;
                      if (s.isEmpty) e = "Aadhar number cannot be empty";
                      if (!RegExp(r"[0-9]{12}").hasMatch(s))
                        e = "Invalid aadhar number";
                      if (e != null && _firstError == null)
                        _firstError = _aadharFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _fatherFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _father,
                    focusNode: _fatherFocus,
                    keyboardType: TextInputType.text,
                    labelText: 'Father\'s Name',
                    validator: (String s) {
                      String e;
                      if (s.isEmpty) e = "Father's name cannot be empty";
                      if (e != null && _firstError == null)
                        _firstError = _fatherFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _motherFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _mother,
                    focusNode: _motherFocus,
                    keyboardType: TextInputType.text,
                    labelText: 'Mother\'s Name',
                    validator: (String s) {
                      String e;
                      if (s.isEmpty) e = "Mother's name cannot be empty";
                      if (e != null && _firstError == null)
                        _firstError = _motherFocus;
                      return e;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: DropdownFormField(
                    items: ['SC', 'ST', 'OBC', 'GEN'],
                    controller: _category,
                    title: 'Category',
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your Permanent Address',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    minLines: 1,
                    maxLines: 4,
                    scrollPhysics: BouncingScrollPhysics(),
                    controller: _perAddress,
                    focusNode: _perAddressFocus,
                    keyboardType: TextInputType.text,
                    labelText: 'Permanent Address',
                    validator: (String s) {
                      String e;
                      if (s.isEmpty) e = "Address cannot be empty";
                      if (e != null && _firstError == null)
                        _firstError = _perAddressFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _perDistrictFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _perDistrict,
                    focusNode: _perDistrictFocus,
                    keyboardType: TextInputType.text,
                    labelText: 'District',
                    validator: (String s) {
                      String e;
                      if (s.isEmpty) s = "District cannot be empty";
                      if (e != null && _firstError == null)
                        _firstError = _perDistrictFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _perCityFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: FormInputField(
                          controller: _perCity,
                          focusNode: _perCityFocus,
                          keyboardType: TextInputType.text,
                          labelText: 'City',
                          validator: (String s) {
                            String e;
                            if (s.isEmpty) e = "City cannot be empty";
                            if (e != null && _firstError == null)
                              _firstError = _perCityFocus;
                            return e;
                          },
                          onFieldSubmitted: (s) => _perPinFocus.requestFocus(),
                        ),
                      ),
                      SizedBox(width: 12),
                      Flexible(
                        child: FormInputField(
                          controller: _perPin,
                          focusNode: _perPinFocus,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
                          labelText: 'Pin Code',
                          validator: (String s) {
                            String e;
                            if (s.isEmpty)
                              e = "Pin cannot be empty";
                            else if (!RegExp(r"[0-9]{6}").hasMatch(s))
                              e = "Invalid Pin";
                            if (e != null && _firstError == null)
                              _firstError = _perPinFocus;
                            return e;
                          },
                          onFieldSubmitted: (s) =>
                              _preAddressFocus.requestFocus(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your Present Address',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _preAddress,
                    focusNode: _preAddressFocus,
                    minLines: 1,
                    maxLines: 4,
                    scrollPhysics: BouncingScrollPhysics(),
                    keyboardType: TextInputType.text,
                    labelText: 'Present Address',
                    validator: (String s) {
                      String e;
                      if (s.isEmpty) e = "Address cannot be empty";
                      if (e != null && _firstError == null)
                        _firstError = _preAddressFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _preDistrictFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: FormInputField(
                    controller: _preDistrict,
                    focusNode: _preDistrictFocus,
                    keyboardType: TextInputType.text,
                    labelText: 'District',
                    validator: (String s) {
                      String e;
                      if (s.isEmpty) e = "District cannot be empty";
                      if (e != null && _firstError == null)
                        _firstError = _preDistrictFocus;
                      return e;
                    },
                    onFieldSubmitted: (s) => _preCityFocus.requestFocus(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: FormInputField(
                          controller: _preCity,
                          focusNode: _preCityFocus,
                          keyboardType: TextInputType.text,
                          labelText: 'City',
                          validator: (String s) {
                            String e;
                            if (s.isEmpty) e = "City cannot be empty";
                            if (e != null && _firstError == null)
                              _firstError = _preCityFocus;
                            return e;
                          },
                          onFieldSubmitted: (s) => _prePinFocus.requestFocus(),
                        ),
                      ),
                      SizedBox(width: 12),
                      Flexible(
                        child: FormInputField(
                          controller: _prePin,
                          focusNode: _prePinFocus,
                          keyboardType: TextInputType.number,
                          labelText: 'Pin Code',
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
                          validator: (String s) {
                            String e;
                            if (s.isEmpty)
                              e = "Pin cannot be empty";
                            else if (!RegExp(r"[0-9]{6}").hasMatch(s))
                              e = "Invalid Pin";
                            if (e != null && _firstError == null)
                              _firstError = _prePinFocus;
                            return e;
                          },
                          onFieldSubmitted: (s) => _onSubmit(),
                        ),
                      ),
                    ],
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
    if (_formKey.currentState.validate() && _imageError == null) {
      _updateStudent();
      widget.onNext();
    } else if (_imageError != null)
      _scrollController.animateTo(0,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    else if (_firstError != null) {
      _firstError.unfocus();
      Future.delayed(
        Duration(milliseconds: 50),
            () => _firstError.requestFocus(),
      );
    }
  }

  void _updateStudent() {
    _student.newImage = _newImage;
    _student.newImageName = _imageName;
    _student.name = _name.text;
    _student.email = _email.text;
    _student.alternateEmail = _altEmail.text.isEmpty ? null : _altEmail.text;
    _student.dob = _dob.text;
    _student.gender = _gender.text;
    _student.phone = _phone.text;
    _student.alternatePhone = _altPhone.text.isEmpty ? null : _altPhone.text;
    _student.aadhar = _aadhar.text;
    _student.fatherName = _father.text;
    _student.motherName = _mother.text;
    _student.category = _category.text;
    _student.permanentAddress = _perAddress.text;
    _student.permanentDistrict = _perDistrict.text;
    _student.permanentCity = _perCity.text;
    _student.permanentPin = int.parse(_perPin.text);
    _student.presentAddress = _preAddress.text;
    _student.presentDistrict = _preDistrict.text;
    _student.presentCity = _preCity.text;
    _student.presentPin = int.parse(_prePin.text);
  }
}
