import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter/foundation.dart' show kIsWeb;

class DateFormField extends StatefulWidget {
  final TextEditingController controller;
  final String title;

  const DateFormField({Key key, @required this.controller, this.title})
      : super(key: key);

  @override
  _DateFormFieldState createState() => _DateFormFieldState();
}

class _DateFormFieldState extends State<DateFormField> {
  DateTime _date;

  @override
  void initState() {
    _date = DateTime.parse(widget.controller.text);
    super.initState();
  }

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
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                DateFormat('dd MMM yyyy').format(_date),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Icon(
              Icons.calendar_today,
              color: Theme.of(context).textTheme.subtitle1.color,
            ),
          ],
        ),
      ),
    );
    return GestureDetector(
      child: kIsWeb
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
            ),
      onTap: () async {
        DateTime dt = await showDatePicker(
          context: context,
          initialDate: _date,
          firstDate: DateTime(1980, 1, 1),
          lastDate: DateTime(2040, 12, 31),
        );
        if (dt != null)
          setState(() {
            _date = dt;
            widget.controller.text = DateFormat('yyyy-MM-dd').format(dt);
          });
      },
    );
  }
}
