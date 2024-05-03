import 'package:flutter/material.dart';
import 'package:sous_chef_app/services/image_helper.dart';
import 'package:sous_chef_app/services/server.dart';
import 'package:sous_chef_app/widgets/image_upload_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sous_chef_app/recipe_db.dart';

class CustomRecipe extends StatefulWidget {
  final void Function({String? title, String? ingredients, String? instructions, String? image})? onUpdate;
  final int? id;
  final String? title;
  final String? ingredients;
  final String? instructions;
  final String? image;

  const CustomRecipe({super.key, 
    this.id,
    this.onUpdate,
    this.title,
    this.ingredients,
    this.instructions,
    this.image,
  });

  @override
  _CustomRecipeState createState() => _CustomRecipeState();
}

class _CustomRecipeState extends State<CustomRecipe> {
  late final TextEditingController _titleController = TextEditingController();
  late final TextEditingController _ingredientsController = TextEditingController();
  late final TextEditingController _instructionsController = TextEditingController();
  String? _image;
  bool edit = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.image != null && widget.image != "") {
      _image = widget.image;
    }
    if (widget.title != null) {
      edit = true;
      _titleController.text = widget.title!;
    }
    if (widget.ingredients != null) {
      _ingredientsController.text = widget.ingredients!;
    }
    if (widget.instructions != null) {
      _instructionsController.text = widget.instructions!;
    }
    
    _titleController.addListener(() {
      setState(() {});
    });
    _ingredientsController.addListener(() {
      setState(() {});
    });
    _instructionsController.addListener(() {
      setState(() {});
    });
  }



  Future<void> saveRecipe() async {
    final url = Uri.parse('http://${Server.address}/add_recipe/');

    final recipeData = {
      'title': _titleController.text,
      'instructions': "${_titleController.text} \n Ingredients: \n ${_ingredientsController.text} \n Instructions: \n ${_instructionsController.text}",
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
      print('Recipe saved successfully!');
    } else {
      // Handle error, e.g., show an error message
      print('Failed to save recipe: ${response.body}');
    }
  }

  Future<void> editRecipe(editId) async {
    final url = Uri.parse('http://${Server.address}/edit_recipe/$editId');

    final recipeData = {
      'name': _titleController.text,
      'instructions': "${_titleController.text} \n Ingredients: \n ${_ingredientsController.text} Instructions: \n ${_instructionsController.text}",
      'recipe_longtext': _image ?? '',
    };

    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(recipeData),
    );

    if (response.statusCode == 200) {
      // Handle success, e.g., show a success message
      print('Recipe item $editId edited successfully!');
    } else {
      // Handle error, e.g., show an error message
      print('Failed to edit recipe item $editId: ${response.body}');
    }
  }


  @override
  Widget build(BuildContext context) {
    final imageHelper = ImageHelper();

    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 244, 247, 234),
      title: Text(
        edit ? 'Edit' : 'Custom Recipe',
        style: const TextStyle(
          color: Color.fromARGB(255, 67, 107, 31),
          fontWeight: FontWeight.w600,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            (_image == null || _image == "") ? 
            Container(
              height: 216,
              width: 270,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              child: const Icon(
                Icons.add_photo_alternate_outlined,
                size: 60,
                color: Colors.grey,
              ),
            )
            : ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: imageHelper.getImageWidget(
                image: _image,
                height: 216,
                width: 270,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ImageUploadButton(
                onImageSelected: (String? image) {
                  setState(() {
                    _image = image;
                  });
                },
              ),
            ),
            TextFormField(
              cursorColor: const Color.fromARGB(155, 67, 107, 31),
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(155, 67, 107, 31)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              cursorColor: const Color.fromARGB(155, 67, 107, 31),
              controller: _ingredientsController,
              decoration: const InputDecoration(
                labelText: 'Ingredients',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(155, 67, 107, 31)),
                ),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              cursorColor: const Color.fromARGB(155, 67, 107, 31),
              controller: _instructionsController,
              decoration: const InputDecoration(
                labelText: 'Instructions',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(155, 67, 107, 31)),
                ),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: (_isLoading || _titleController.text.isEmpty || _ingredientsController.text.isEmpty || _instructionsController.text.isEmpty)
                      ? null
                      : () async {
                          // Set loading state to true
                          setState(() {
                            _isLoading = true;
                          });

                          String? encodedImage;
                          if (_image != null && _image != "") {
                            if (imageHelper.isNetworkImage(_image!) || imageHelper.isValidFilePath(_image!)) {
                              encodedImage = await imageHelper.encodeImage(_image!);
                              _image = encodedImage;
                            }
                          }

                          if (widget.onUpdate != null) {
                            widget.onUpdate!(
                              title: _titleController.text,
                              ingredients: _ingredientsController.text,
                              instructions: _instructionsController.text,
                              image: _image,
                            );
                          
                            await editRecipe(widget.id);
                            print("edited recipe");
                          } else {
                            print("new custom recipe");
                            await saveRecipe();
                          }

                          recipeDB().fetchRecipes();
                          
                          // Reset loading state after saving
                          setState(() {
                            _isLoading = false;
                          });

                          Navigator.of(context).pop();
                        },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return const Color.fromARGB(36, 67, 107, 31); 
                      }
                      return const Color.fromARGB(255, 67, 107, 31); 
                    }),
                  ),
                  child: _isLoading
                      ? const SizedBox( // Show loading indicator if saving
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          edit ? 'Save Changes' : 'Save',
                          style: const TextStyle(color: Colors.white),
                        ), // Show 'Save' text if not saving
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
