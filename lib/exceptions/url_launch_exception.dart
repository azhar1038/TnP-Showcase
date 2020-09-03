import 'package:tnp/exceptions/base_exception.dart';

class UrlLaunchException extends BaseException {
  UrlLaunchException([String message]) : super(message, "CANNOT LAUNCH URL:");
}
