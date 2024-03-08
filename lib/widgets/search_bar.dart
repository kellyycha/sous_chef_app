import 'package:flutter/material.dart';

// TODO: ad search bar logic using this resource:
// https://www.dhiwise.com/post/flutter-search-bar-tutorial-for-building-a-powerful-search-functionality

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      alignment: Alignment.centerLeft,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search',
          fillColor: const Color.fromARGB(255, 230, 230, 230),
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
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}