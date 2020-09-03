import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/app/theme_data.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Widget leading;

  const TopBar({
    Key key,
    @required this.title,
    this.leading,
  }) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();

  @override
  Size get preferredSize {
//    if (kIsWeb)
//      return Size.fromHeight(80);
//    else
      return Size.fromHeight(48);
  }
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _opacityAnimation, _alignmentAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.4,
          1,
          curve: Curves.easeOut,
        ),
      ),
    );
    _alignmentAnimation =
        AlignmentTween(begin: Alignment.bottomCenter, end: Alignment.center)
            .animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(TopBar oldWidget) {
    if (widget.title != oldWidget.title) {
      _controller.reset();
      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    top = top < 4 ? 4 : top;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.color,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10),
          BoxShadow(
              color: Theme.of(context).scaffoldBackgroundColor,
              blurRadius: 10,
              offset: Offset(0, -10)),
        ],
        border: Theme.of(context).appBarTheme.color !=
                appTheme[ThemeType.Light].appBarTheme.color
            ? Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              )
            : null,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            widget.leading == null?Container(
              width: 48,
              child: Image.asset(
                'assets/images/igit_logo_mini.png',
                fit: BoxFit.contain,
              ),
            ):widget.leading,
            SizedBox(width: 16),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  alignment: _alignmentAnimation.value,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
