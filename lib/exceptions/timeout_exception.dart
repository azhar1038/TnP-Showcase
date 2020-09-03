import 'package:tnp/exceptions/base_exception.dart';

class TimeoutException extends BaseException {
  TimeoutException() : super("An Asynchronous task failed to complete resulting in exception.", "TIMEOUT");
}
