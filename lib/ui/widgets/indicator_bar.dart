import 'package:flutter/material.dart';

class IndicatorBar extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Orientation orientation;
  static const double Thickness = 50;

  const IndicatorBar({
    Key key,
    this.currentIndex = 0,
    this.orientation = Orientation.portrait,
    @required this.count,
  })  : assert(currentIndex <= count && currentIndex >= 0),
        assert(count > 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget bottomIndicator = LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: Thickness,
          width: constraints.maxWidth,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).bottomAppBarColor,
            border:
                Border(top: BorderSide(color: Theme.of(context).dividerColor)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: getIndicators(context),
          ),
        );
      },
    );

    Widget sideIndicator = LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).bottomAppBarColor,
            border: Border(
                right: BorderSide(color: Theme.of(context).dividerColor)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: getIndicators(context),
            ),
          ),
        );
      },
    );


    return orientation == Orientation.portrait
        ? bottomIndicator
        : sideIndicator;
  }

  List<Widget> getIndicators(BuildContext context) {
    List<Widget> indicators = [];
    for (int i = 0; i < count; i++) {
      indicators.add(
        Container(
          height: 15,
          width: 15,
          alignment: Alignment.center,
          child: i == currentIndex
              ? Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
                )
              : Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Color(0xff898989),
                  ),
                ),
        ),
      );
    }
    return indicators;
  }
}
