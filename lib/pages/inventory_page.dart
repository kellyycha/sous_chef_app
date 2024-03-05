import 'package:flutter/material.dart';
import 'package:sous_chef_app/item_square.dart';

class InventoryPage extends StatelessWidget {
  InventoryPage({super.key});

  final List _refrigerator = [
    "orange",
    "tomato", 
    "apple", 
    "broccoli",
    "carrot",
    "cauliflower",
    "eggs",
    "tofu",
    ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          

          //inventory list
          Expanded(
            child: ListView.builder(
              itemCount: _refrigerator.length,
              itemBuilder: (context, index) {
                return MySquare(
                  child: _refrigerator[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 