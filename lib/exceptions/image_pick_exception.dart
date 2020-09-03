import 'package:tnp/exceptions/base_exception.dart';

class ImagePickException extends BaseException {
  ImagePickException([String message]) : super(message, "IMAGE PICK FAILED: ");
}
