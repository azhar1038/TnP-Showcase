import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tnp/ui/smart_widgets/sign_up/sign_up_model.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpModel>.nonReactive(
      builder: (context, model, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            child: Text(
              'Not yet registered?',
              style: Theme.of(context).textTheme.headline6,
            ),
            onPressed: model.launchRegister,
          ),
        );
      },
      viewModelBuilder: () => SignUpModel(),
    );
  }
}
