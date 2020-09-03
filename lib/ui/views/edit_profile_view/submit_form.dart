import 'package:flutter/material.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/ui/widgets/centered.dart';
import 'package:tnp/ui/widgets/fade_in.dart';

class SubmitForm extends StatefulWidget {
  final VoidCallback onPrevious, onSubmit;

  const SubmitForm({
    Key key,
    @required this.onPrevious,
    @required this.onSubmit,
  }) : super(key: key);
  @override
  _SubmitFormState createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:24.0),
        child: Centered(
          maxWidth: maxWidth,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'Reminder',
                    style: Theme.of(context)
                        .textTheme
                        .headline5,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Text(
                    'Your data will only be updated after it has been verified by' +
                        ' your respective Training and Placement Coordinator.' +
                        ' After submitting you will not be able to request for another'+
                        ' update until the previous one has been verified.',
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Back'),
                      onPressed: widget.onPrevious,
                    ),
                    RaisedButton(
                      child: Text('Submit'),
                      onPressed: widget.onSubmit,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
