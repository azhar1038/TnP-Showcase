import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tnp/ui/smart_widgets/sign_up/sign_up.dart';
import 'package:tnp/ui/views/validate_view/validate_form.dart';
import 'package:tnp/ui/widgets/centered.dart';
import 'package:tnp/ui/widgets/login_logo.dart';

class ValidateView extends StatelessWidget {
  final _emailController = TextEditingController();
  final _regnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: OrientationLayoutBuilder(
        landscape: (context) => ConstrainedBox(
          constraints: BoxConstraints(minHeight: height),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LoginLogo(),
                      SignUp(),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Centered(
                  maxWidth: 500,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: ValidateForm(
                      emailController: _emailController,
                      regnController: _regnController,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        portrait: (context) => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: height),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                LoginLogo(),
                ValidateForm(
                  emailController: _emailController,
                  regnController: _regnController,
                ),
                SignUp(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
