import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sous_chef_app/widgets/dropdown.dart';
import 'package:sous_chef_app/widgets/item_square.dart';
import 'package:sous_chef_app/widgets/search_bar.dart';

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

  final List<String> _location = <String>[
    'All', 
    'Refrigerator', 
    'Freezer', 
    'Pantry',
    'Spices/Sauces'
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              const SizedBox(
                height:140,
                // title
                child: Align(
                  alignment: Alignment.topLeft,
                    child:Padding(
                    padding:EdgeInsets.only(top:40,left:20),
                    child: Text(
                      'Inventory',
                      style: TextStyle(
                        color:Colors.black,
                        fontSize: 64.0,
                        fontFamily: 'Italiana',
                      ),
                    ),
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    const SizedBox(width:10),
                    // location dropdown
                    SizedBox(
                      width: 260,
                      height: 40,
                      child: LocationDropdown(data: _location),
                      ),
                    const VerticalDivider(
                      width: 20,
                      thickness: 1,
                      indent: 3,
                      endIndent: 3,
                    ),
                    // video button
                    SizedBox(
                      width: 87,
                      height: 40,
                      child: IconButton.outlined(
                        icon: const Icon(Icons.videocam_outlined),
                        iconSize: 40,
                        color: Colors.black,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(1),
                        // TODO: clicking this button shows video feed
                        onPressed: () {},
                        ), 
                      ), 
                    const Spacer(),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              Row(
                children: [
                  const SizedBox(width:10),
                  // search bar
                  const SizedBox(
                    width: 315,
                    height: 40,
                    child: MySearchBar(),
                    ),
                  const SizedBox(width:5),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 230, 230, 230),
                        ),
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        iconSize: 40,
                        color: Colors.black,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(1),
                        // TODO: clicking this adds custom item
                        onPressed: () {},
                        ),
                    ), 
                    ), 
                  const Spacer(),
                ],
              ),

            ]
          ),
          //inventory list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
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
