import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DropdownFormField extends StatefulWidget {
  final List<String> items;
  final TextEditingController controller;
  final String title;

  const DropdownFormField({
    Key key,
    @required this.items,
    @required this.controller,
    @required this.title,
  }) : super(key: key);

  @override
  _DropdownFormFieldState createState() => _DropdownFormFieldState();
}

class _DropdownFormFieldState extends State<DropdownFormField> {
  @override
  Widget build(BuildContext context) {
    Widget field = Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        border: Border.all(
          color: Theme.of(context).inputDecorationTheme.border.borderSide.color,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: DropdownButton<String>(
          isExpanded: true,
          items: widget.items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              widget.controller.text = value;
            });
          },
          value: widget.controller.text,
          style: Theme.of(context).textTheme.subtitle1,
          underline: Container(),
          iconSize: 32,
          icon: Icon(Icons.keyboard_arrow_down),
          dropdownColor: Theme.of(context).cardColor,
          iconEnabledColor: Theme.of(context).textTheme.subtitle1.color,
        ),
      ),
    );
    return kIsWeb
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(widget.title,
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              field,
            ],
          )
        : Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              field,
              Positioned(
                top: -8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Text(
                    widget.title,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                  ),
                ),
              ),
            ],
          );
  }
}
