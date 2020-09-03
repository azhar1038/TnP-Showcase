import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'image_pick_model.dart';

class ImagePick extends StatelessWidget {
  final void Function(Uint8List image, String name, String error) onPick;
  final VoidCallback onClear;

  const ImagePick({
    Key key,
    this.onPick,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ImagePickModel>.reactive(
      builder: (context, model, child) {
        return Container(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/profile.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                      Container(
                        child: model.studentImage != null
                            ? Image.network(
                                'https://home.igitplacements.ac.in/media/${model.studentImage}',
                                width: 100,
                                height: 100,
                                fit: BoxFit.contain,
                                loadingBuilder: (context, child, progress) {
                                  return progress == null
                                      ? child
                                      : Center(
                                          child: CircularProgressIndicator(),
                                        );
                                },
                              )
                            : Container(),
                      ),
                      model.image != null
                          ? Image.memory(
                              model.image,
                              height: 100,
                              width: 100,
                              fit: BoxFit.contain,
                            )
                          : Container(color: Colors.transparent)
                    ],
                  ),
                  SizedBox(width: 24),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RaisedButton(
                        child: Text(' New '),
                        onPressed: () async {
                          await model.pickImage();
                          onPick(model.image, model.imageName, model.pickError);
                        },
                      ),
                      RaisedButton(
                        child: Text('Clear'),
                        onPressed: () {
                          model.clearImage();
                          onClear();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              model.pickError == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        model.pickError ?? '',
//                        style: Theme.of(context).textTheme.subtitle2.copyWith(
//                              color: Theme.of(context).errorColor,
//                            ),
                        style:
                            Theme.of(context).inputDecorationTheme.errorStyle,
                      ),
                    ),
            ],
          ),
        );
      },
      viewModelBuilder: () => ImagePickModel(),
    );
  }
}
