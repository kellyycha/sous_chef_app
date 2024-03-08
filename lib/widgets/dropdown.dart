import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  final List data; 

  const MyDropdown({super.key, required this.data});

  @override
  State<MyDropdown> createState() => _LocationState();
}

class _LocationState extends State<MyDropdown> {
  late String dropdownValue = widget.data.first;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:260,
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<String>(
          value: dropdownValue,
          // alignment: Alignment.center,
          icon: const Icon(Icons.arrow_drop_down_circle_outlined),
          iconSize: 30,
          iconEnabledColor: Colors.white,
          decoration: InputDecoration(
            fillColor: const Color.fromARGB(255, 67, 107, 31),
            filled: true,
            contentPadding:const EdgeInsets.symmetric(horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
          ),
          dropdownColor: const Color.fromARGB(255, 67, 107, 31),
          elevation: 0,
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          },
          items: widget.data.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(value,
                  style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20),),
              )
            );
          }).toList(),
        ),
      )
    );
  }
}