import 'package:tnp/exceptions/base_exception.dart';

class BadRequestException extends BaseException {
  BadRequestException([String message]) : super(message, "BAD REQUEST");
}
