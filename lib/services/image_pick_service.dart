import 'dart:typed_data';

import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:injectable/injectable.dart';
import 'package:tnp/exceptions/image_pick_exception.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

@lazySingleton
class ImagePickService {
  static ImagePickerPlatform _imagePicker = ImagePickerPlatform.instance;

  Future<Map<String, dynamic>> pickImage({
    ImageSource source = ImageSource.gallery,
    double maxSize = 512000,
  }) async {
    Uint8List _image;
    PickedFile _pickedFile;
    try {
      _pickedFile = await _imagePicker.pickImage(source: source);
      if(_pickedFile != null) _image = await _pickedFile.readAsBytes();
    } catch (error) {
      print(error);
      throw ImagePickException("Something went wrong. Try again later.");
    }

    if (_image != null) {
      int _length = _image.length;
      String _ext = _pickedFile.path.split('.').last;
      if (_length > maxSize)
        throw ImagePickException(
            "Image size should be less than ${maxSize ~/ 1024} KB");
      else if (!kIsWeb && _ext != "jpeg" && _ext != "jpg" && _ext != "png") {
        throw ImagePickException("Only jpeg, jpg and png are accepted.");
      }
    }
    return {
      'image': _image,
      'name': _pickedFile.path.split('/').last,
    };
  }
}
