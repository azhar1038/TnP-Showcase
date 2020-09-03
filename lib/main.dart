import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tnp/app/locator.dart';

import 'package:tnp/app.dart';
import 'package:tnp/app/setup_dialog_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await setupLocator();
  setUpDialogUi();
  runApp(TnP());
}
