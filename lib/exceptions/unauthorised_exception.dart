import 'package:tnp/exceptions/base_exception.dart';

class UnauthorisedException extends BaseException {
  UnauthorisedException([String message]) : super(message, "ACCESS DENIED");
}
