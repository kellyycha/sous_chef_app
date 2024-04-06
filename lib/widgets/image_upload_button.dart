import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadButton extends StatelessWidget {
  final void Function(File? image)? onImageSelected;

  const ImageUploadButton({Key? key, this.onImageSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      width: 100,
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: const Color.fromARGB(255, 67, 107, 31),
          foregroundColor: Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(1),
        ),
        onPressed: () async {
          final pickedImage = await showModalBottomSheet<File?>(
            backgroundColor: Color.fromARGB(255, 219, 235, 188),
            context: context,
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('From Photo Library'),
                    onTap: () async {
                      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                      Navigator.pop(context, pickedImage != null ? File(pickedImage.path) : null);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('From Camera'),
                    onTap: () async {
                      final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
                      Navigator.pop(context, pickedImage != null ? File(pickedImage.path) : null);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Remove Image'),
                    onTap: () {
                      Navigator.pop(context, null);
                    },
                  ),
                ],
              );
            },
          );

          if (onImageSelected != null) {
            onImageSelected!(pickedImage);
          }
        },
        child: const Text("Upload Image"),
      ),
    );
  }
}
