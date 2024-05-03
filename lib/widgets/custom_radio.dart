// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sous_chef_app/food_db.dart';
import 'package:sous_chef_app/recipe_db.dart';

class MyRadio extends StatefulWidget {
  final String firstText;
  final double firstWidth;
  final String secondText;
  final double secondWidth;
  final Function(String) onSortBy;

  const MyRadio({super.key,
    required this.firstText,
    required this.firstWidth,
    required this.secondText,
    required this.secondWidth,
    required this.onSortBy
    });

  @override
  State<MyRadio> createState() => _MyRadioState();
}


class _MyRadioState extends State<MyRadio> {
  int value = 1;

  void sortBy(String text) {
    print(text);
    if (text == "Expiration") {
      inventory.sort((a, b) => a[3].compareTo(b[3]));
      entireInventory.sort((a, b) => a[3].compareTo(b[3]));
    } else if (text == 'A-Z') {
      inventory.sort((a, b) => a[1].compareTo(b[1]));
      entireInventory.sort((a, b) => a[1].compareTo(b[1]));
      allRecipes.sort((a, b) => a[1].compareTo(b[1]));
      recipes.sort((a, b) => a[1].compareTo(b[1]));
    } else if (text == 'Recent') {
      allRecipes.sort((a, b) => a[2].compareTo(b[2]));
      recipes.sort((a, b) => a[2].compareTo(b[2]));
    }
    setState(() {});
  }


  Widget CustomRadioButton(String text, int index, double width) {
    return SizedBox(
      height: 40,
      width: width,
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            value = index;
            // Pass the selected sorting option to the parent widget
            widget.onSortBy(text);
          });
        },

        style: OutlinedButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            ),
          backgroundColor: (value == index) ? const Color.fromARGB(255, 67, 107, 31) : Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(1),
          side: BorderSide(color: (value == index) ? Colors.transparent: const Color.fromARGB(255, 230, 230, 230)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: (value == index) ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CustomRadioButton(widget.firstText, 1, widget.firstWidth),
        const SizedBox(width:5),
        CustomRadioButton(widget.secondText, 2, widget.secondWidth),
      ],
    );
  }
}