import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tnp/ui/views/login_link_view/login_link_form_model.dart';
import 'package:tnp/ui/widgets/form_input_field.dart';

class LoginLinkForm extends StatefulWidget {
  final TextEditingController passwordController;

  const LoginLinkForm({
    Key key,
    @required this.passwordController,
  }) : super(key: key);

  @override
  _LoginLinkFormState createState() => _LoginLinkFormState();
}

class _LoginLinkFormState extends State<LoginLinkForm>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  LoginLinkFormModel _model;

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
    return ViewModelBuilder<LoginLinkFormModel>.reactive(
      viewModelBuilder: () => LoginLinkFormModel(),
      onModelReady: (model) => _model = model,
      builder: (context, model, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 120,
                alignment: Alignment.center,
                child: Text(
                  'Welcome back,\n${model.studentName}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 24),
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: FormInputField(
                    controller: widget.passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    labelText: 'Password',
                    validator: model.validatePassword,
                    onFieldSubmitted: (s) => onSubmit(model),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 24),
                alignment: Alignment.center,
                child: RaisedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(' Login  '),
                  ),
                  onPressed: () => onSubmit(model),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void onSubmit(LoginLinkFormModel model) {
    if (_formKey.currentState.validate())
      model.loginAndLinkDevice(widget.passwordController.text);
  }
}
