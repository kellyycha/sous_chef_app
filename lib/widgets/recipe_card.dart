// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sous_chef_app/services/image_helper.dart';
import 'package:sous_chef_app/services/server.dart';
import 'package:sous_chef_app/widgets/bullet_widget.dart';
import 'package:sous_chef_app/widgets/custom_edit_recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeCard extends StatefulWidget {
  final int? id;
  final String? recipeResponse;
  String title;
  final String? image;

  RecipeCard({super.key,
    this.id, 
    required this.recipeResponse, 
    required this.title, 
    this.image,
  });

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  late bool isSaved;
  String? _image;
  String _ingredientsStr = '';
  String _instructionsStr = '';

  @override
  void initState() {
    super.initState();
    _image = widget.image;
    // if has id, true, if not, false
    isSaved = true; 
    _extractRecipeData();
  }

  void _extractRecipeData() {
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

    _ingredientsStr = ingredients.join('\n');

    int instructionsStartIndex = ingredientsEndIndex + 1;
    List<String> instructions = lines.sublist(instructionsStartIndex)
        .where((element) => element.trim().isNotEmpty)
        .map((instruction) => instruction.replaceAll(RegExp(r'^[\-*]\s*|\d+\.\s*'), ''))
        .toList();

    _instructionsStr = instructions.join('\n');
  }

  void updateRecipe({String? title, String? ingredients, String? instructions, String? image}) {
    setState(() {
      widget.title = title!;
    });
    setState(() {
      _ingredientsStr = ingredients!;
    });
    setState(() {
      _instructionsStr = instructions!;
    });
    setState(() {
      _image = image;
    });
  }

  Future<void> saveRecipe() async {
      //TODO: SERVER CHANGE API CALL
    final url = Uri.parse('http://${Server.address}/add_recipe/');
    

    final recipeData = {
      'name': widget.title,
      'instructions': widget.recipeResponse,
      'recipe_longtext': _image ?? '',
    };

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(recipeData),
    );

    if (response.statusCode == 200) {
      // Handle success, e.g., show a success message
      print('Food item saved successfully!');
    } else {
      // Handle error, e.g., show an error message
      print('Failed to save food item: ${response.body}');
    }
  }

  Future<void> deleteRecipe() async {
    try {
      final deleteQuery = "http://${Server.address}/remove_recipe/${widget.id}";
      final response = await http.delete(Uri.parse(deleteQuery));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print(jsonData);
      } else {
        throw Exception('Failed to delete Recipe');
      }
    } catch (e) {
      print('Error deleting recipe: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageHelper = ImageHelper();

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
                    child: imageHelper.getImageWidget(
                      image: _image,
                      height: 264,
                      width: 330,
                    ),
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
                        isSaved ? SizedBox(
                          width: 130,
                          height: 30,
                          child: TextButton.icon(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomRecipe(
                                    title: widget.title,
                                    ingredients: _ingredientsStr,
                                    instructions: _instructionsStr,
                                    image: _image,
                                    onUpdate: updateRecipe,
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 20, 
                            ),
                            label: const Text(
                              'Edit Recipe',
                            ),
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              backgroundColor: const Color.fromARGB(255, 67, 107, 31),
                              foregroundColor: Colors.white,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(0),
                            ),
                          ),
                        ) : const Spacer(),
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
                                
                                String? encodedImage;
                                if (isSaved) {
                                  if (_image != null){
                                    if (imageHelper.isNetworkImage(_image!) || imageHelper.isValidFilePath(_image!)) {
                                      encodedImage = await imageHelper.encodeImage(_image!);
                                      _image = encodedImage;
                                    }
                                  }
                                  print("save");
                                  saveRecipe();

                                } else {
                                  print("remove");
                                  deleteRecipe();
                                }
                              },
                            ), 

                          ),
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
                            BulletList(_ingredientsStr.split('\n')),
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
                              children: _instructionsStr.split('\n').asMap().entries.map((entry) => ListTile(
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
