import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/ui/widgets/loader.dart';

void setUpDialogUi() {
  DialogService _dialogService = locator<DialogService>();

  _dialogService.registerCustomDialogUi((context, req) {
    if (req.customData == DialogType.Alert) {
      assert(req.title != null && req.description != null);
      return AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(req.title),
        content: Text(req.description),
        actions: [
          FlatButton(
            child: Text(req.mainButtonTitle ?? 'Ok'),
            onPressed: () => _dialogService.completeDialog(DialogResponse()),
          ),
        ],
      );
    } else if (req.customData == DialogType.Wait) {
      assert(req.title != null);
      return WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Loader(text: req.title, color: Colors.white,),
        ),
      );
    } else {
      assert(req.title != null && req.description != null);
      return WillPopScope(
        onWillPop: () async {
          _dialogService.completeDialog(
            DialogResponse(confirmed: false),
          );
          return false;
        },
        child: AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text(req.title),
          content: Text(req.description),
          actions: [
            FlatButton(
              child: Text(req.mainButtonTitle ?? 'Yes'),
              onPressed: () => _dialogService.completeDialog(
                DialogResponse(confirmed: true),
              ),
            ),
            FlatButton(
              child: Text(req.secondaryButtonTitle ?? 'No'),
              onPressed: () => _dialogService.completeDialog(
                DialogResponse(confirmed: false),
              ),
            ),
          ],
        ),
      );
    }
  });
}
