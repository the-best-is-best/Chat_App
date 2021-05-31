import 'package:image_picker/image_picker.dart';

import '/models/user_image_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserImagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.greenAccent[300],
          backgroundImage:
              context.watch<UserIamgeModel>().pickedFile.path.isNotEmpty
                  ? FileImage(context.watch<UserIamgeModel>().pickedFile)
                  : null,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: () => context
                  .read<UserIamgeModel>()
                  .pickerImage(ImageSource.camera),
              icon: Icon(
                Icons.photo_camera_outlined,
                size: 20,
              ),
              label: Text(
                'Add Image \n From Camira',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            TextButton.icon(
              onPressed: () => context
                  .read<UserIamgeModel>()
                  .pickerImage(ImageSource.gallery),
              icon: Icon(Icons.image_outlined),
              label: Text(
                'Add Image \n From Gallery',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
      ],
    );
  }
}
