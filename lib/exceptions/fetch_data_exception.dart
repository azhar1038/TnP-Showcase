import 'package:tnp/exceptions/base_exception.dart';

class FetchDataException extends BaseException {
  FetchDataException([String message]) : super(message, "FETCHING ERROR");
}
