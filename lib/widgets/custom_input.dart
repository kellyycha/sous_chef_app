import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sous_chef_app/widgets/dropdown.dart';
import 'package:sous_chef_app/widgets/image_upload_button.dart'; 

class CustomInput extends StatefulWidget {
  final void Function(File? image)? onImageSelected;

  const CustomInput({super.key,
    this.onImageSelected
  });

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late TextEditingController _titleController;
  late TextEditingController _expirationDateController;
  late TextEditingController _quantityController;
  late String _locationSelected;
  File? _image;

  final List<String> _location = <String>[
    'Refrigerator', 
    'Freezer', 
    'Pantry',
    'Spices/Sauces'
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _expirationDateController = TextEditingController();
    _quantityController = TextEditingController();
    _locationSelected = _location[0];

    _titleController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 67, 107, 31),
              onPrimary: Color.fromARGB(255, 205, 219, 192),
              surface: Color.fromARGB(255, 225, 235, 206),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        _expirationDateController.text = DateFormat('MM/dd/yyyy').format(pickedDate);
      });
    }
  }

  void setLocation(String location) {
    _locationSelected = location;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 244, 247, 234),
      title: const Text(
        'Custom Input',
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
                child: Image.file(
                    _image!,
                    height: 168,
                    width: 210,
                    fit: BoxFit.cover
                  )
              )
              : Container(
                height: 168,
                width: 210,
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
                  onImageSelected: (File? image) {
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
                  labelText: 'Title *',
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
            SizedBox(
              width: 250,
              height: 40,
              child: MyDropdown(
                data: _location,
                onSelect: setLocation,
              ), 
            ),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: IgnorePointer(
                child: TextFormField(
                  controller: _expirationDateController,
                  decoration: const InputDecoration(labelText: 'Expiration Date'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Spacer(),
                IconButton(
                  color: const Color.fromARGB(255, 67, 107, 31),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 1.0, color:Color.fromARGB(255, 67, 107, 31)),
                  ),
                  alignment: Alignment.center,
                  onPressed: () {
                    int currentQuantity = int.tryParse(_quantityController.text) ?? 0;
                    setState(() {
                      _quantityController.text = (currentQuantity - 1).clamp(0, 9999).toString();
                    });
                  },
                  icon: const Icon(Icons.remove),
                ),
                SizedBox(
                  width: 40,
                  child: TextFormField(
                    cursorColor: const Color.fromARGB(155, 67, 107, 31),
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Qty',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(155, 67, 107, 31)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    ),
                  ),
                ),
                IconButton(
                  color: const Color.fromARGB(255, 67, 107, 31),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 1.0, color:Color.fromARGB(255, 67, 107, 31)),
                  ),
                  alignment: Alignment.center,
                  onPressed: () {
                    int currentQuantity = int.tryParse(_quantityController.text) ?? 0;
                    setState(() {
                      _quantityController.text = (currentQuantity + 1).clamp(0, 9999).toString();
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: _titleController.text.isEmpty ? null : () { 
                    // TODO: Save data in inventory DB
                    print(_titleController.text);
                    print(_locationSelected);
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
