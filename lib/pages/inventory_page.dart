import 'package:flutter/material.dart';
import 'package:sous_chef_app/services/notifications.dart';
import 'package:sous_chef_app/widgets/custom_edit_input.dart';
import 'package:sous_chef_app/widgets/dropdown.dart';
import 'package:sous_chef_app/widgets/item_square.dart';
import 'package:sous_chef_app/widgets/custom_radio.dart';
import 'package:sous_chef_app/widgets/search_bar.dart';
import 'package:sous_chef_app/sample_data.dart';

class InventoryPage extends StatefulWidget {
  InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {

  final List<String> _location = <String>[
    'All', 
    'Refrigerator', 
    'Freezer', 
    'Pantry',
    'Spices/Sauces'
    ];

  void handleLocationSelection(String location) {
    // TODO: Filter inventory based on selected location
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
                  itemCount: inventory.length,
                  itemBuilder: (context, index) {
                    return MySquare(
                      title: inventory[index][0],
                      qty: inventory[index][1],
                      expiration: inventory[index][2],
                      img: inventory[index][4],
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomInput(
                              title: inventory[index][0],
                              qty: inventory[index][1],
                              expiration: inventory[index][2],
                              location: inventory[index][3],
                              image: inventory[index][4],
                              onItemUpdated: (String? updatedImage, String? updatedTitle, int? updatedQty, int? updatedExpiration, String? updatedLocation) {
                                setState(() {
                                  inventory[index][0] = updatedTitle ?? inventory[index][0];
                                  inventory[index][1] = updatedQty ?? inventory[index][1];
                                  inventory[index][2] = updatedExpiration ?? inventory[index][2];
                                  inventory[index][3] = updatedLocation ?? inventory[index][3];
                                  inventory[index][4] = updatedImage ?? inventory[index][4];
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