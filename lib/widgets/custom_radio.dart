// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class MyRadio extends StatefulWidget {
  final String firstText;
  final double firstWidth;
  final String secondText;
  final double secondWidth;

  const MyRadio({super.key,
    required this.firstText,
    required this.firstWidth,
    required this.secondText,
    required this.secondWidth
    });

  @override
  State<MyRadio> createState() => _MyRadioState();
}

void sortBy(String text) {
    print(text);
    //TODO: sort according to value (expiration, recent, or a-z)
  }

class _MyRadioState extends State<MyRadio> {
  int value = 1;

  Widget CustomRadioButton(String text, int index, double width) {
    return SizedBox(
      height: 40,
      width: width,
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            value = index;
            sortBy(text);
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