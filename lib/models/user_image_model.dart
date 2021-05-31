import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserIamgeModel with ChangeNotifier {
  ImagePicker picker = ImagePicker();
  File pickedFile = File('');

  void pickerImage(ImageSource src) async {
    final pickedImageFile =
        await picker.getImage(source: src, imageQuality: 50, maxWidth: 150);

    if (pickedImageFile != null) {
      pickedFile = File(pickedImageFile.path);
      notifyListeners();
    }
  }

  void removeImage() {
    pickedFile = File('');
    notifyListeners();
  }
}
