import 'package:flutter/material.dart';
import 'package:sous_chef_app/services/image_helper.dart';
import 'package:sous_chef_app/widgets/image_upload_button.dart';

class CustomRecipe extends StatefulWidget {
  final void Function({String? title, String? ingredients, String? instructions, String? image})? onUpdate;
  final String? title;
  final String? ingredients;
  final String? instructions;
  final String? image;

  CustomRecipe({
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

  @override
  void initState() {
    super.initState();

    if (widget.image != null) {
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
            _image != null ? 
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: imageHelper.getImageWidget(
                image: _image,
                height: 216,
                width: 270,
              ),
            )
            : Container(
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
                    _instructionsController.text.isEmpty) ? null : () async {
                      
                      String? encodedImage;
                      if (_image != null){
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
                      
                        //TODO: save changes to DB
                        print("edited recipe");
                      }
                      else {
                        //TODO: save new recipe to DB
                        print("new custom recipe");
                      }

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
                  child: Text(
                    edit ? 'Save Changes' : 'Save',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
