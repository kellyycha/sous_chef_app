import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sous_chef_app/services/encode_image.dart';

class ImageHelper {
  bool isNetworkImage(String imageUrl) {
    return imageUrl.startsWith('http://') || imageUrl.startsWith('https://');
  }

  bool isValidFilePath(String path) {
    final file = File(path);
    return file.existsSync();
  }

  Future<String?> encodeImage(String image) async {
    String? encodedImage;
    
    if (isNetworkImage(image)){
      // print("network");
      encodedImage = await networkImageToBase64(image);
    }

    else if (isValidFilePath(image)){
      // print("file");
      encodedImage = await fileImageToBase64(image);
    }
    // print(encodedImage); 
    return encodedImage;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String image) async {
    final path = await _localPath;
    String filename = image.substring(image.length - 20).replaceAll('/', '1');
    return File('$path/$filename.png');
  }

  Widget getImageWidget({
    required String? image,
    required double height,
    required double width,
  }) {
    if (isNetworkImage(image!)) {
      return Image.network(
        image,
        height: height,
        width: width,
        fit: BoxFit.cover,
      );
    } else if (isValidFilePath(image)) {
      return Image.file(
        File(image),
        height: height,
        width: width,
        fit: BoxFit.cover,
      );
    } else { // Encoded image
      final decodedBytes = base64Decode(image);
      return FutureBuilder<File>(
        future: _localFile(image),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final file = snapshot.data!;
            file.writeAsBytesSync(decodedBytes);
            return Image.file(
              file,
              height: height,
              width: width,
              fit: BoxFit.cover,
            );
          } 
          else {
            return SizedBox(
              height: height,
              width: width, 
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 67, 107, 31),
                ),
              ),
            );
          }
        },
      );
    }
  }
  
  Future<File> writeText(String text) async {
    final path = await _localPath;
    final file = File('$path/saved.txt');
    print(file);

    return file.writeAsString(text);
  }

}
