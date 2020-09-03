import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tnp/datamodels/navbar_item.dart';

class NavbarSide extends StatefulWidget {
  final void Function(int index) onChange;
  final List<NavbarItem> items;
  final Color activeColor;
  final int initialIndex;

  const NavbarSide({
    Key key,
    @required this.onChange,
    @required this.items,
    @required this.activeColor,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _NavbarSideState createState() => _NavbarSideState();
}

class _NavbarSideState extends State<NavbarSide> {
  static const double INDICATOR_WIDTH = 2;
  static const Duration DURATION = Duration(milliseconds: 400);
  int _currentIndex;

  double _getIndicatorPosition(int index) {
    return -1 + 2 / (widget.items.length - 1) * index;
  }

  @override
  void initState() {
    _currentIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double fullHeight = constraints.maxHeight;
      double height;
      double barWidth;
      var deviceType = getDeviceType(MediaQuery.of(context).size);
      switch (deviceType) {
        case DeviceScreenType.desktop:
          barWidth = 200;
          height = fullHeight > 200 ? 200 : fullHeight;
          break;
        case DeviceScreenType.tablet:
          barWidth = 80;
          height = fullHeight > 300 ? 300 : fullHeight;
          break;
        default:
          barWidth = 50;
          height = fullHeight > 300 ? 300 : fullHeight;
      }
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          border: Border(
            right: BorderSide(
              width: 1,
              color: Theme.of(context).dividerColor,
            ),
          ),
        ),
        child: SafeArea(
          child: Container(
            height: fullHeight,
            width: barWidth,
            child: Column(
              children: [
                deviceType == DeviceScreenType.desktop
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/igit_logo.png",
                            width: 120,
                          ),
                          Text(
                            'T&P Cell\nIGIT Sarang',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontSize: 16),
                          ),
                          SizedBox(height: 16),
                        ],
                      )
                    : Container(),
                Expanded(
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Positioned(
                        right: INDICATOR_WIDTH,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: widget.items.map((item) {
                            int index = widget.items.indexOf(item);
                            return GestureDetector(
                              onTap: () => _select(index),
                              child: _buildItem(item, index == _currentIndex,
                                  height, barWidth),
                            );
                          }).toList(),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        height: height,
                        child: AnimatedAlign(
                          alignment: Alignment(
                              0, _getIndicatorPosition(_currentIndex)),
                          duration: DURATION,
                          child: Container(
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .selectedIconTheme
                                .color,
                            height: height / widget.items.length,
                            width: INDICATOR_WIDTH,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  _select(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      widget.onChange(index);
      setState(() {});
    }
  }

  Widget _buildIcon(NavbarItem item, bool isSelected) {
    return Icon(
      item.icon,
      color: isSelected
          ? Theme.of(context).bottomNavigationBarTheme.selectedIconTheme.color
          : Theme.of(context)
              .bottomNavigationBarTheme
              .unselectedIconTheme
              .color,
//      color: widget.activeColor,
      size: 20,
    );
  }

  _buildItem(NavbarItem item, bool isSelected, double height, double width) {
    return ScreenTypeLayout(
      mobile: Container(
        width: width,
        height: height / widget.items.length,
        color: Theme.of(context).bottomAppBarColor,
        child: AnimatedAlign(
          alignment: isSelected ? Alignment.center : Alignment.centerRight,
          duration: DURATION,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 30,
                alignment: Alignment.center,
                child: _buildIcon(item, isSelected),
              ),
              AnimatedOpacity(
                opacity: isSelected ? 1.0 : 0.0,
                duration: DURATION,
                child: getTitle(item.title, isSelected, rotate: true),
              ),
            ],
          ),
        ),
      ),
      tablet: Container(
        width: width,
        height: height / widget.items.length,
        child: AnimatedAlign(
          alignment: isSelected ? Alignment.center : Alignment.bottomCenter,
          duration: DURATION,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 30,
                alignment: Alignment.center,
                child: _buildIcon(item, isSelected),
              ),
              AnimatedOpacity(
                  opacity: isSelected ? 1.0 : 0.0,
                  duration: DURATION,
                  child: getTitle(item.title, isSelected)),
            ],
          ),
        ),
      ),
      desktop: Container(
        width: width,
        height: height / widget.items.length,
        color: isSelected
            ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
            : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 30,
              width: 50,
              alignment: Alignment.center,
              child: _buildIcon(item, isSelected),
            ),
            getTitle(item.title, isSelected)
          ],
        ),
      ),
    );
  }

  Widget getTitle(String title, bool isSelected, {bool rotate = false}) {
    Text text = Text(
      title,
      overflow: TextOverflow.fade,
      softWrap: false,
      style: isSelected
          ? Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle
          : Theme.of(context).bottomNavigationBarTheme.unselectedLabelStyle,
    );
    return rotate ? RotatedBox(quarterTurns: 3, child: text) : text;
  }
}
