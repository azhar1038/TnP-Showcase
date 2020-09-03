import 'package:flutter/material.dart';

class StartupAnimation extends StatefulWidget {
  @override
  _StartupAnimationState createState() => _StartupAnimationState();
}

class _StartupAnimationState extends State<StartupAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _align;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _align = Tween<double>(begin: 0, end: -0.7).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    ));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _align,
      builder: (context, child) {
        return Container(
          alignment: Alignment(0, _align.value),
          child: Image.asset(
            'assets/images/igit_logo.png',
            height: 200,
            width: 200,
          ),
        );
      },
      child: Container(
        child: Image.asset(
          'assets/images/igit_logo.png',
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
