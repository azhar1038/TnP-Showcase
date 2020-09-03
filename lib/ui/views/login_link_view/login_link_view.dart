import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tnp/ui/smart_widgets/forgot_password/forgot_password.dart';
import 'package:tnp/ui/widgets/centered.dart';
import 'package:tnp/ui/widgets/login_logo.dart';

import 'login_link_form.dart';

class LoginLinkView extends StatelessWidget {
  final _passwordController = TextEditingController();

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
                      ForgotPassword(),
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
                    child: LoginLinkForm(
                      passwordController: _passwordController,
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
                LoginLinkForm(
                  passwordController: _passwordController,
                ),
                ForgotPassword(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
