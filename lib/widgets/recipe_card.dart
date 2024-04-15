import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sous_chef_app/services/encode_image.dart';
import 'package:sous_chef_app/widgets/bullet_widget.dart';
import 'package:sous_chef_app/widgets/image_upload_button.dart';

class RecipeCard extends StatefulWidget {
  final String? recipeResponse;
  final String title;
  final String? image;

  final void Function(String? image)? onImageSelected;

  const RecipeCard({super.key, 
    required this.recipeResponse, 
    required this.title, 
    this.image,
    this.onImageSelected
  });

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  late bool isSaved;
  String? _image;

  @override
  void initState() {
    super.initState();
    _image = widget.image;

    // TODO: check if recipe is in the DB. yes: isSaved true. no: isSaved false
    isSaved = false; 

  }

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
      print("network");
      encodedImage = await networkImageToBase64(image);
    }

    else if (isValidFilePath(image)){
      print("file");
      encodedImage = await fileImageToBase64(image);
    }
    print(encodedImage); 
    return encodedImage;
  }

  Widget getImageWidget(image) {
    if (isNetworkImage(image)) {
      return Image.network(
        image!,
        height: 264,
        width: 330,
        fit: BoxFit.cover,
      );
    } else if (isValidFilePath(image)) {
      return Image.file(
        File(image!),
        height: 264,
        width: 330,
        fit: BoxFit.cover,
      );
    } else { // Encoded image
      final decodedBytes = base64Decode(image);
      var file = File("test.png");
      file.writeAsBytesSync(decodedBytes);
      return Image.file(
        file,
        height: 264,
        width: 330,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> lines = widget.recipeResponse!.split('\n');

    int findIngredientsIndex(List<String> lines) {
      for (int i = 0; i < lines.length; i++) {
        if (lines[i].toLowerCase().contains('ingredients')) {
          return i;
        }
      }
      return -1;
    }
    int findInstructionsIndex(List<String> lines) {
      for (int i = 0; i < lines.length; i++) {
        if (lines[i].toLowerCase().contains('instructions')) {
          return i;
        }
      }
      return -1;
    }

    int ingredientsStartIndex = findIngredientsIndex(lines) + 1;
    int ingredientsEndIndex = findInstructionsIndex(lines);

    List<String> ingredients = lines.sublist(ingredientsStartIndex, ingredientsEndIndex)
        .where((element) => element.trim().isNotEmpty)
        .map((ingredient) => ingredient.replaceAll(RegExp(r'^[\-*]\s*|\d+\.\s*'), ''))
        .toList();

    int instructionsStartIndex = ingredientsEndIndex + 1;
    List<String> instructions = lines.sublist(instructionsStartIndex)
        .where((element) => element.trim().isNotEmpty)
        .map((instruction) => instruction.replaceAll(RegExp(r'^[\-*]\s*|\d+\.\s*'), ''))
        .toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 245),
      body: Column( 
        children: [
          const SizedBox(height: 50),
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              iconSize: 35,
              color: Colors.black,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(1),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _image != null ? 
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: getImageWidget(_image)
                  )
                  : Container(
                    height: 264,
                    width: 330,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:BorderRadius.all(Radius.circular(18)),
                    ),
                    child: const Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 70,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        ImageUploadButton(
                          onImageSelected: (String? image) {
                            setState(() {
                              _image = image;
                            });
                          },
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 30,
                            child: IconButton(
                              icon: Icon(
                                isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                              ),
                              iconSize: 35,
                              color: isSaved ? const Color.fromARGB(255, 67, 107, 31) : Colors.black,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(1),
                              onPressed: () async {
                                setState(() {
                                  isSaved = !isSaved;
                                });
                                if (isSaved) {
                                  

                                  if (_image != null){
                                    if (isNetworkImage(_image!) || isValidFilePath(_image!)) {
                                      var encodedImage = await encodeImage(_image!);
                                    }
                                  }
                                  print("save");

                                  // TODO: save to DB as [title, recipe, date saved, encodedImage]

                                } else {
                                  print("remove");

                                  // TODO: remove from DB
                                }
                              },
                            ), 

                          )
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 20,
                        right: 20,
                        bottom: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 243, 243, 237),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        )
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20), 
                            const Text(
                              'Ingredients:', 
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                              )
                            ),
                            const SizedBox(height: 8),
                            BulletList(ingredients),
                            const SizedBox(height: 16),
                            const Text(
                              'Instructions:', 
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                              )
                            ),
                            const SizedBox(height: 8),
                            Column(
                              children: instructions.asMap().entries.map((entry) => ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: const Color.fromARGB(255, 219, 235, 188),
                                  foregroundColor: const Color.fromARGB(255, 67, 107, 31),
                                  child: Text('${entry.key + 1}'),
                                  ),
                                title: Text(
                                  entry.value,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    height: 1.5,
                                  ),
                                ),
                              )).toList(),
                            ),
                          ],
                        ),
                      ),
                    ]
                  ),
                  const SizedBox(height: 20),
                ],
              )
            ),
          ),
        ]
      )
    );
  }
}
