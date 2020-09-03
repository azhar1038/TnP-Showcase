import 'package:flutter/material.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/app/theme_data.dart';
import 'package:tnp/datamodels/navbar_item.dart';

class NavbarBottom extends StatefulWidget {
  final void Function(int index) onChange;
  final List<NavbarItem> items;
  final Color activeColor;
  final int initialIndex;

  const NavbarBottom({
    Key key,
    @required this.onChange,
    @required this.items,
    @required this.activeColor,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _NavbarBottomState createState() => _NavbarBottomState();
}

class _NavbarBottomState extends State<NavbarBottom> {
  static const double BAR_HEIGHT = 50;
  static const double INDICATOR_HEIGHT = 2;
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
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
        border: Theme.of(context).appBarTheme.color !=
                appTheme[ThemeType.Light].appBarTheme.color
            ? Border(
                top:
                    BorderSide(color: Theme.of(context).dividerColor, width: 1))
            : null,
      ),
      child: SafeArea(
        child: Container(
          height: BAR_HEIGHT,
          width: width,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                top: INDICATOR_HEIGHT,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: widget.items.map((item) {
                    int index = widget.items.indexOf(item);
                    return GestureDetector(
                      onTap: () => _select(index),
                      child: _buildItem(item, index == _currentIndex, width),
                    );
                  }).toList(),
                ),
              ),
              Positioned(
                top: -1,
                width: width,
                child: AnimatedAlign(
                  alignment: Alignment(_getIndicatorPosition(_currentIndex), 0),
                  duration: DURATION,
                  child: Container(
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedIconTheme
                        .color,
                    width: width / widget.items.length,
                    height: INDICATOR_HEIGHT,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
      size: 20,
    );
  }

  _buildItem(NavbarItem item, bool isSelected, double width) {
    return Container(
      height: BAR_HEIGHT,
      width: width / widget.items.length,
      color: Theme.of(context).bottomAppBarColor,
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
              child: Text(
                item.title,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedLabelStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
