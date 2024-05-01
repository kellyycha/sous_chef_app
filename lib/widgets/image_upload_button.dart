import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadButton extends StatelessWidget {
  final void Function(String? image)? onImageSelected;

  const ImageUploadButton({super.key, this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    bool remove = false;
    return SizedBox(
      height: 26,
      width: 110,
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: const Color.fromARGB(255, 67, 107, 31),
          foregroundColor: Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(1),
        ),
        onPressed: () async {
          final pickedImage = await showModalBottomSheet<String?>(
            backgroundColor: const Color.fromARGB(255, 219, 235, 188),
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
                      Navigator.pop(context, pickedImage?.path);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('From Camera'),
                    onTap: () async {
                      final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
                      Navigator.pop(context, pickedImage?.path);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Remove Image'),
                    onTap: () {
                      remove = true;
                      Navigator.pop(context, null);
                    },
                  ),
                  SizedBox(height: 20)
                ],
              );
            },
          );

          if (remove) {
            onImageSelected!(null); 
          }

          if (pickedImage != null && onImageSelected != null) {
            // print(pickedImage);
            onImageSelected!(pickedImage);
          }
        },

        child: const Text("Upload Image"),
      ),
    );
  }
}
