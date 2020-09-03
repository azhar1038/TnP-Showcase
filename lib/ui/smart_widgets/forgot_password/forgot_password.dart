import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tnp/ui/smart_widgets/forgot_password/forgot_password_model.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordModel>.nonReactive(
      builder: (context, model, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            child: Text(
              'Forgot Password?',
              style: Theme.of(context).textTheme.headline6,
            ),
            onPressed: model.forgotPassword,
          ),
        );
      },
      viewModelBuilder: () => ForgotPasswordModel(),
    );
  }
}
