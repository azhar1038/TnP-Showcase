import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Loader extends StatelessWidget {
  final String text;
  final Color color;

  const Loader({
    Key key,
    @required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color c = color ?? Theme.of(context).accentColor;
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            child: kIsWeb
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(c),
                  )
                : FlareActor(
                    'assets/flare/loader.flr',
                    animation: 'loading',
                    alignment: Alignment.center,
                    color: c,
                  ),
          ),
          SizedBox(height: 32),
          Text(
            text,
            style: Theme.of(context).textTheme.subtitle2.copyWith(color: c),
          ),
        ],
      ),
    );
  }
}
