import 'package:tnp/exceptions/base_exception.dart';

class DatabaseServiceException extends BaseException {
  DatabaseServiceException([String message]) : super(message, "DATABASE EXCEPTION:");
}
