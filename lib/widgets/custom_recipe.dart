import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sous_chef_app/widgets/image_upload_button.dart';

class CustomRecipe extends StatefulWidget {
  final void Function(File? image)? onImageSelected;

  const CustomRecipe({super.key,
    this.onImageSelected
  });

  @override
  _CustomRecipeState createState() => _CustomRecipeState();
}

class _CustomRecipeState extends State<CustomRecipe> {
  late TextEditingController _titleController;
  late TextEditingController _ingredientsController;
  late TextEditingController _instructionsController;
  String? _image;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _ingredientsController = TextEditingController();
    _instructionsController = TextEditingController();

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

  bool isNetworkImage(String imageUrl) {
    return imageUrl.startsWith('http://') || imageUrl.startsWith('https://');
  }

  Widget getImageWidget(image) {
    if (isNetworkImage(image)) {
      return Image.network(
        image!,
        height: 216,
        width: 270,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(image!),
        height: 216,
        width: 270,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 244, 247, 234),
      title: const Text(
        'Custom Recipe',
        style: TextStyle(
          color: Color.fromARGB(255, 67, 107, 31),
          fontWeight: FontWeight.w600,
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              _image != null ? 
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: getImageWidget(_image)
              )
              : Container(
                height: 216,
                width: 270,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:BorderRadius.all(Radius.circular(18)),
                ),
                child: const Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 60,
                  color: Colors.grey,
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
                  onPressed: (_titleController.text.isEmpty || 
                    _ingredientsController.text.isEmpty || 
                    _instructionsController.text.isEmpty) ? null : () {

                    String recipe = _titleController.text;
                    recipe += "\n\nIngredients:\n\n";
                    recipe += _ingredientsController.text;
                    recipe += "\n\nInstructions:\n\n";
                    recipe += _instructionsController.text;
                    print(recipe);

                    // TODO: Save data in DB [title, recipe, today's date, image]

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
                  
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
    );
  }
}
