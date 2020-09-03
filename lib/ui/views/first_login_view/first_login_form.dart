import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tnp/ui/views/first_login_view/first_login_form_model.dart';

class FirstLoginForm extends StatefulWidget {
  final TextEditingController passwordController, confirmController;

  const FirstLoginForm({
    Key key,
    @required this.passwordController,
    @required this.confirmController,
  }) : super(key: key);

  @override
  _FirstLoginFormState createState() => _FirstLoginFormState();
}

class _FirstLoginFormState extends State<FirstLoginForm>
    with WidgetsBindingObserver {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode _confirmFocusNode;
  FirstLoginFormModel _model;

  @override
  void initState() {
    _confirmFocusNode = FocusNode();
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
    _confirmFocusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FirstLoginFormModel>.reactive(
      viewModelBuilder: () => FirstLoginFormModel(),
      onModelReady: (model) => _model = model,
      builder: (context, model, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              Container(
                height: 120,
                alignment: Alignment.center,
                child: Text(
                  'Welcome,\n${model.studentName}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5,
                ),
              ),
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: TextFormField(
                          controller: widget.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'New Password',
                          ),
                          validator: model.validatePassword,
                          onFieldSubmitted: (s) => FocusScope.of(context)
                              .requestFocus(_confirmFocusNode),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: TextFormField(
                          focusNode: _confirmFocusNode,
                          controller: widget.confirmController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                          ),
                          validator: (s) => model.validateConfirm(
                              s, widget.passwordController.text),
                          onFieldSubmitted: (s) {
                            onSubmit(model);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 24),
                alignment: Alignment.center,
                child: RaisedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Register',
                    ),
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

  void onSubmit(FirstLoginFormModel model) {
    if (_formKey.currentState.validate()) {
      model.firstLogin(widget.passwordController.text);
    }
  }
}
