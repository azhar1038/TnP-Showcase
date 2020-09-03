import 'package:flutter/material.dart';

class Centered extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const Centered({Key key,@required this.child, this.maxWidth=1200}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
