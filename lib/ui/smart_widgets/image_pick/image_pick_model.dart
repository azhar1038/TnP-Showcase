import 'dart:typed_data';

import 'package:stacked/stacked.dart';
import 'package:tnp/exceptions/image_pick_exception.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/managers/user_manager.dart';
import 'package:tnp/services/image_pick_service.dart';

class ImagePickModel extends BaseViewModel {
  ImagePickService _imagePickService = locator<ImagePickService>();
  UserManager _userManager = locator<UserManager>();
  String _pickError, _name;
  Uint8List _image;

  String get pickError => _pickError;

  Uint8List get image => _image;

  String get imageName => _name;

  String get studentImage => _userManager.student.image;

  Future<void> pickImage() async {
    Map<String, dynamic> file;
    try {
      file = await _imagePickService.pickImage();
      _pickError = null;
      _image = file['image'];
      _name = file['name'];
    } on ImagePickException catch (error) {
      _pickError = error.message;
    }
    notifyListeners();
  }

  void clearImage() {
    _image = null;
    _name = null;
    _pickError = null;
    notifyListeners();
  }
}
