import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _image;

  final _picker = ImagePicker();

  void selectImage(File pickedImage) {}

  Future<void> _takePicture() async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    final imageFile = File(pickedFile.path);

    setState(() {
      if (pickedFile != null) {
        _image = imageFile;
      } else {
        print('No image seleted.');
      }
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);

    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _image != null
              ? Image.file(
                  _image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        TextButton.icon(
          onPressed: _takePicture,
          icon: Icon(Icons.camera),
          label: Text(
            'Take Picture',
          ),
        ),
      ],
    );
  }
}
