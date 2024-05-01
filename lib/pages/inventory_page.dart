import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sous_chef_app/services/server.dart';
import 'dart:convert';
import 'package:sous_chef_app/widgets/custom_edit_input.dart';
import 'package:sous_chef_app/widgets/dropdown.dart';
import 'package:sous_chef_app/widgets/item_square.dart';
import 'package:sous_chef_app/widgets/custom_radio.dart';
import 'package:sous_chef_app/widgets/search_bar.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<List<dynamic>> _inventory = [];
  final List<List<dynamic>> _entireInventory = [];

  @override
  void initState() {
    super.initState();
    _fetchInventoryData();
  }

  Future<void> _fetchInventoryData() async {
    try {
      final response = await http.get(Uri.parse('http://${Server.address}/inventory/'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        jsonData.forEach((key, value) {
          int id = value['id'];
          String name = value['name'];
          int quantity = value['quantity'];
          String expirationDate = value['expiration_date'];
          String location = value['food_type'];
          String imageUrl = value['image_url'];

          // Calculate days left from today to expiration date
          DateTime today = DateTime.now();
          DateTime expiryDate = DateTime.parse(expirationDate);
          int daysLeft = expiryDate.difference(today).inDays;

          // Create list of food details
          List<dynamic> foodDetails = [
            id,
            name,
            quantity,
            daysLeft,
            location,
            imageUrl,
          ];

          // Add food details to _inventory list
          setState(() {
            _inventory.add(foodDetails);
            _entireInventory.add(foodDetails);
          });
        });
      } else {
        throw Exception('Failed to load inventory');
      }
    } catch (e) {
      print('Error fetching inventory: $e');
    }
  }

  final List<String> _location = <String>[
    'All', 
    'Refrigerator', 
    'Freezer', 
    'Pantry',
    'Spices/Sauces'
    ];

  void handleLocationSelection(String location) {
    // Filter inventory based on selected location
    List<List<dynamic>> filteredInventory = [];

    for (List<dynamic> item in _entireInventory) {
      String itemLocation = item[4]; // Location is at index 3 in the item list
      if (itemLocation == location || location == 'All') {
        filteredInventory.add(item);
      }
    }

    // Update _inventory to display filtered items
    setState(() {
      _inventory = filteredInventory;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const ColoredBox(color: Colors.white),
          Positioned(
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
                      child: MyDropdown(
                        data: _location,
                        onSelect: handleLocationSelection,
                      ), 
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
                         onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const CustomInput(); 
                            },
                          );
                        },
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
                      id: _inventory[index][0],
                      title: _inventory[index][1],
                      qty: _inventory[index][2],
                      expiration: _inventory[index][3],
                      img: _inventory[index][5],
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomInput(
                              id: _inventory[index][0],
                              title: _inventory[index][1],
                              qty: _inventory[index][2],
                              expiration: _inventory[index][3],
                              location: _inventory[index][4],
                              image: _inventory[index][5],
                              onItemUpdated: (String? updatedImage, String? updatedTitle, int? updatedQty, int? updatedExpiration, String? updatedLocation) {
                                setState(() {
                                  _inventory[index][1] = updatedTitle ?? _inventory[index][1];
                                  _inventory[index][2] = updatedQty ?? _inventory[index][2];
                                  _inventory[index][3] = updatedExpiration ?? _inventory[index][3];
                                  _inventory[index][4] = updatedLocation ?? _inventory[index][4];
                                  _inventory[index][5] = updatedImage ?? _inventory[index][5];
                                });
                              },
                            );
                          },
                        );
                      },
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