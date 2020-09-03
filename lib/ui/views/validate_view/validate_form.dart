import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:tnp/ui/views/validate_view/validate_form_model.dart';
import 'package:tnp/ui/widgets/form_input_field.dart';

class ValidateForm extends StatefulWidget {
  final TextEditingController regnController;
  final TextEditingController emailController;

  ValidateForm({
    Key key,
    @required this.regnController,
    @required this.emailController,
  }) : super(key: key);

  @override
  _ValidateFormState createState() => _ValidateFormState();
}

class _ValidateFormState extends State<ValidateForm>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final _emailFocus = FocusNode();
  ValidateFormModel _model;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _model != null) {
      _model.reloadTheme();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ValidateFormModel>.reactive(
      viewModelBuilder: () => ValidateFormModel(),
      onModelReady: (model) => _model = model,
      builder: (context, model, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: Text('Login',
                      style: Theme.of(context).textTheme.headline5),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: FormInputField(
                    controller: widget.regnController,
                    keyboardType: TextInputType.number,
                    labelText: 'Registration No.',
                    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                    validator: model.validateRegn,
                    onFieldSubmitted: (s) {
                      FocusScope.of(context).requestFocus(_emailFocus);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: FormInputField(
                    controller: widget.emailController,
                    focusNode: _emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email Id',
                    validator: model.validateEmail,
                    onFieldSubmitted: (s) => submit(model),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 24),
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Continue',
                      ),
                    ),
                    onPressed: () => submit(model),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void submit(ValidateFormModel model) {
    if (_formKey.currentState.validate())
      model.validate(
        widget.regnController.text,
        widget.emailController.text,
      );
  }
}
