import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const MySearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      alignment: Alignment.centerLeft,
      child: TextField(
        cursorColor: const Color.fromARGB(155, 67, 107, 31),
        onChanged: onSearch,
        decoration: InputDecoration(
          labelText: 'Search',
          labelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600
          ),
          fillColor: const Color.fromARGB(255, 230, 230, 230),
          filled: true,
          prefixIconColor: Colors.black,
          contentPadding:const EdgeInsets.symmetric(horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}