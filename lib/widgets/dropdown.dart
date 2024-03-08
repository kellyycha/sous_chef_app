import 'package:flutter/material.dart';

class LocationDropdown extends StatefulWidget {
  final List data; 

  const LocationDropdown({super.key, required this.data});

  @override
  State<LocationDropdown> createState() => _LocationState();
}

class _LocationState extends State<LocationDropdown> {
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
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
          dropdownColor: const Color.fromARGB(255, 67, 107, 31),
          elevation: 0,
          onChanged: (String? value) {
            // This is called when the user selects an item.
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