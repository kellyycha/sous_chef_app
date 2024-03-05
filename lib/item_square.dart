import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MySquare extends StatelessWidget{
  final String child;
  
  MySquare({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(20)
        ),
        
        child: Center(
          child: Text(
            child,
            style: const TextStyle(
              fontSize: 40),
            )
          )
        )
    );
  }
}