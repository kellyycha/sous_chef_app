import 'package:flutter/material.dart';
import 'dart:io';

import 'package:sous_chef_app/widgets/bullet_widget.dart';
import 'package:sous_chef_app/widgets/image_upload_button.dart';

class RecipeCard extends StatefulWidget {
  final String? recipeResponse;
  final String title;
  final File? image;

  final void Function(File? image)? onImageSelected;

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
  bool isSaved = false;
  File? _image;

  @override
  void initState() {
    super.initState();
    _image = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    List<String> lines = widget.recipeResponse!.split('\n');

    int ingredientsStartIndex = lines.indexOf('Ingredients:') + 1;
    int ingredientsEndIndex = lines.indexOf('Instructions:');
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
                    child: Image.file(
                        _image!,
                        height: 264,
                        width: 330,
                        fit: BoxFit.cover
                      )
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
                          onImageSelected: (File? image) {
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
                              onPressed: () {
                                setState(() {
                                  isSaved = !isSaved;
                                });
                                // TODO: save to DB as [title, recipe, date saved, image].
                                // if opened from saved tab, it should stay filled in and remove from DB if unchecked.
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
