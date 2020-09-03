import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tnp/ui/widgets/centered.dart';
import 'package:tnp/ui/widgets/login_logo.dart';

import 'first_login_form.dart';

class FirstLoginView extends StatelessWidget {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

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
                    child: FirstLoginForm(
                      passwordController: _passwordController,
                      confirmController: _confirmController,
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
                FirstLoginForm(
                  passwordController: _passwordController,
                  confirmController: _confirmController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
