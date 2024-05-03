import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sous_chef_app/widgets/custom_edit_input.dart';
import 'package:sous_chef_app/widgets/dropdown.dart';
import 'package:sous_chef_app/widgets/item_square.dart';
import 'package:sous_chef_app/widgets/custom_radio.dart';
import 'package:sous_chef_app/widgets/search_bar.dart';
import 'package:sous_chef_app/food_db.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  String _searchQuery = '';
  foodDB thisFoodDB = foodDB();
  String _sortBy = 'Expiration';

  @override
  void initState() {
    super.initState();
    setState(() {
      thisFoodDB.fetchInventoryData();
      sortBy(_sortBy);
    });
    _refreshInventoryData();
  }

  Future<void> _refreshInventoryData() async {
    if (!mounted) return;

    await thisFoodDB.fetchInventoryData();

    if (mounted) {
      setState(() {});
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

    for (List<dynamic> item in entireInventory) {
      String itemLocation = item[4]; // Location is at index 3 in the item list
      if (itemLocation == location || location == 'All') {
        filteredInventory.add(item);
      }
    }

    // Update _inventory to display filtered items
    setState(() {
      inventory = filteredInventory;
    });
  }


  void handleSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase(); 
      inventory = entireInventory.where((item) {
        final itemName = item[1].toLowerCase();
        return itemName.contains(_searchQuery);
      }).toList();
      // Sort the filtered inventory based on the current sorting option
      sortBy(_sortBy);
    });
  }

  void sortBy(String sortBy) {
    print(sortBy);
    if (sortBy == "Expiration") {
      inventory.sort((a, b) => a[3].compareTo(b[3]));
    } else if (sortBy == 'A-Z') {
      inventory.sort((a, b) => a[1].toLowerCase().compareTo(b[1].toLowerCase()));
    }
  }

  void handleSortBy(String sortB) {
    setState(() {
      _sortBy = sortB;
      sortBy(_sortBy);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshInventoryData,
        color: const Color.fromARGB(255, 67, 107, 31),
        child: Stack(
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
                    SizedBox(
                      width: 290,
                      height: 40,
                      child: MySearchBar(
                        onSearch: handleSearch,),
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
                Row(
                  children: [
                    const Spacer(),
                    const SizedBox(
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
                    const SizedBox(width:5), 
                    MyRadio(
                      firstText: "Expiration",
                      firstWidth: 105,
                      secondText: "A-Z",
                      secondWidth: 55,
                      onSortBy: handleSortBy,
                    ),
                    const SizedBox(width:20), 
                  ],
                ),
                const SizedBox(height:20), 
                //inventory list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: inventory.length,
                    itemBuilder: (context, index) {
                      return MySquare(
                        id: inventory[index][0],
                        title: inventory[index][1],
                        qty: inventory[index][2],
                        expiration: inventory[index][3],
                        img: inventory[index][5],
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomInput(
                                id: inventory[index][0],
                                title: inventory[index][1],
                                qty: inventory[index][2],
                                expiration: inventory[index][3],
                                location: inventory[index][4],
                                image: inventory[index][5],
                                onItemUpdated: (String? updatedImage, String? updatedTitle, int? updatedQty, int? updatedExpiration, String? updatedLocation) {
                                  setState(() {
                                    inventory[index][1] = updatedTitle ?? inventory[index][1];
                                    inventory[index][2] = updatedQty ?? inventory[index][2];
                                    inventory[index][3] = updatedExpiration ?? inventory[index][3];
                                    inventory[index][4] = updatedLocation ?? inventory[index][4];
                                    inventory[index][5] = updatedImage ?? inventory[index][5];
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
      )
    );
  }
}