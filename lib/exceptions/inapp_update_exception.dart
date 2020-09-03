import 'package:tnp/exceptions/base_exception.dart';

class InAppUpdateException extends BaseException {
  InAppUpdateException([String message]) : super(message, "Failed to update");
}
