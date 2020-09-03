import 'package:flutter/material.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/ui/widgets/centered.dart';
import 'package:tnp/ui/widgets/fade_in.dart';

class Intro extends StatelessWidget {
  final VoidCallback onNext;

  const Intro({Key key, @required this.onNext}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Centered(
          maxWidth: maxWidth,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'Instructions',
                    style: Theme.of(context)
                        .textTheme
                        .headline5,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Text(
                    'This is just a request for updation. This will not directly update your profile.' +
                        ' Your data will only be updated after it has been verified by' +
                        ' your respective Training and Placement Coordinator.' +
                        ' If any of the data is found to be incorrect, your request for' +
                        ' updatation may be rejected. So, make sure all your data in correct' +
                        ' before submitting.\n\nChanges that you make are saved locally, so you can'+
                        ' continue from that part next time you open app again.\n\nIMPORTANT: Changes'+
                        ' are stored section wise and only after you have clicked the Next button.',
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(bottom: 8),
                child: RaisedButton(
                  child: Text('Proceed'),
                  onPressed: onNext,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
