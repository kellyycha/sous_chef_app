import 'package:flutter/material.dart';
import 'package:sous_chef_app/widgets/dropdown.dart';
import 'package:sous_chef_app/widgets/item_square.dart';
import 'package:sous_chef_app/widgets/custom_radio.dart';
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
    ["Soy Sauce", -1, -1, "S"],
    ["Salt", -1, -1, "S"],
    ["Pepper", -1, -1, "S"],
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
      body: Stack(
        children: [
          const ColoredBox(color: Colors.white),
          Positioned(
            // alignment: Alignment.bottomCenter,
            bottom: 0,
            left: 10,
            right: 10,
            child: Container(
              height: 630,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 250, 250, 245),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), 
                  topRight: Radius.circular(30),
                ),
              ),
            )

          ),
          Column(
            children: [
              const SizedBox(
                height:135,
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
              const SizedBox(height:5), 
              IntrinsicHeight(
                child: Row(
                  children: [
                    const SizedBox(width:20),
                    // location dropdown
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: MyDropdown(data: _location),
                      ),
                    const Spacer(),
                    const VerticalDivider(
                      thickness: 1,
                      width: 1,
                      indent: 3,
                      endIndent: 3,
                    ),
                    const Spacer(),
                    // video button
                    SizedBox(
                      width: 80,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.white,
                          ),
                          child: IconButton.outlined(
                            icon: const Icon(Icons.videocam_outlined),
                            iconSize: 40,
                            color: Colors.black,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(width: 1.0, color:Color.fromARGB(255, 194, 194, 194)),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(1),
                            // clicking this button shows video feed
                            onPressed: () {
                              Navigator.pushNamed(context, '/video');
                            },
                          ), 
                        )
                      ), 
                    const SizedBox(width:20),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              const SizedBox(height:5),
              Row(
                children: [
                  const SizedBox(width:20),
                  // search bar
                  const SizedBox(
                    width: 290,
                    height: 40,
                    child: MySearchBar(),
                    ),
                  const Spacer(),
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
                        iconSize: 35,
                        color: Colors.black,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(1),
                        // TODO: clicking this adds custom item
                        onPressed: () {},
                        ),
                      ), 
                    ), 
                  const SizedBox(width:20),
                ],
              ),
              const SizedBox(height:8),
              // sort by options
              const Row(
                children: [
                  Spacer(),
                  SizedBox(
                    height:40,
                    child: Align(
                      alignment: Alignment.centerRight,
                        child:Padding(
                        padding:EdgeInsets.all(0),
                        child: Text(
                          'Sort By',
                          style: TextStyle(
                            color:Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ), 
                  SizedBox(width:5), 
                  MyRadio(
                    firstText: "Expiration",
                    firstWidth: 105,
                    secondText: "A-Z",
                    secondWidth: 55,
                  ),
                  SizedBox(width:20), 
                ],
              ),
              const SizedBox(height:20), 
              //inventory list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _inventory.length,
                  itemBuilder: (context, index) {
                    return MySquare(
                      title: _inventory[index][0],
                      qty: _inventory[index][1],
                      expiration: _inventory[index][2], 
                      // TODO: remove from database
                      onDelete: () {  },
                    );
                  },
                ),
              ),
            ],
          ),

        ]
      )
      
    );
  }
} 