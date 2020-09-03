import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:tnp/app/constants.dart';

import 'locator.iconfig.dart';

final locator = GetIt.instance;

@injectableInit
Future setupLocator() async {
if(kIsWeb) await  $initGetIt(locator, environment: webStr);
else if(Platform.isAndroid) await $initGetIt(locator, environment: androidStr);
}
