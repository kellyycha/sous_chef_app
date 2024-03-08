import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MySquare extends StatelessWidget{
  final String child;
  
  const MySquare({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 243, 243, 237),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color.fromARGB(255, 230, 230, 230)),
        ),
        
        child: Center(
        //TODO: add pics and extra info per page
          child: Text(
            child,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700
              ),
            )
          )
        )
    );
  }
}