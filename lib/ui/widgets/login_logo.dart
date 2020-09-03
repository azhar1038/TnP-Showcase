import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth / 2;
          if (width > 300) width = 300;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/igit_logo.png',
                width: width,
                height: width,
              ),
              Text(
                'Training & Placement Cell',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          );
        },
      ),
    );
  }
}
