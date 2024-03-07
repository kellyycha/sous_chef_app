import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sous_chef_app/item_square.dart';

class InventoryPage extends StatelessWidget {
  InventoryPage({super.key});

  //TODO: use database for this
  final List _inventory = [
    ["Tomato", 2, 7, "R"], 
    ["Potato", 4, 28, "P"],
    ["Garlic", 3, 120, "P"],
    ["Broccoli", 2, 10, "R"],
    ["Banana", 5, 7, "P"],
    ["Cabbage", 1, 20, "R"],
    ["Corn", 2, 5, "R"],
    ["Eggplant", 1, 10, "R"],
    ["Lemon", 4, 30, "R"],
    ["Carrot", 5, 25, "R"],
    ["Steak", 1, 4, "R"],
    ["Egg", 12, 50, "R"],
    ["Avocado", 1, 5, "P"],
    ["Onion", 4, 60, "P"],
    ["Orange", 3, 20, "R"],
    ["Scallion", 6, 14, "R"],
    ["Jalapeno", 4, 9, "R"],
    ["Mushroom", 5, 10, "R"],
    ["Cauliflower", 1, 12, "R"],
    ["Green Bean", 10, 12, "R"],
    ["Soy Sauce", -1, -1, "S"],
    ["Salt", -1, -1, "S"],
    ["Pepper", -1, -1, "S"],
    ["Garlic Powder", -1, -1, "S"],
    ["Paprika", -1, -1, "S"],
    ["Cinnamon", -1, -1, "S"],
    ["Vinegar", -1, -1, "S"],
    ["Sesame Oil", -1, -1, "S"],
    ["Chili Oil", -1, -1, "S"],
    ["Parsley", -1, -1, "S"],
    ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                height:200,
                // title
                child:const Padding(
                  padding:EdgeInsets.only(top:40,left:20),
                  child: Text(
                    'Inventory',
                    style: TextStyle(
                      color:Colors.black,
                      fontSize: 64.0,
                      fontFamily: 'Italiana'
                    ),
                  ),
                ),
              ),
              
            ]
          ),
          //inventory list
          Expanded(
            child: ListView.builder(
              itemCount: _inventory.length,
              itemBuilder: (context, index) {
                return MySquare(
                  child: _inventory[index][0],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 