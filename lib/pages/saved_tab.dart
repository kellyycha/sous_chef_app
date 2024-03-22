import 'package:flutter/material.dart';
import 'package:sous_chef_app/widgets/custom_radio.dart';
import 'package:sous_chef_app/widgets/item_square.dart';
import 'package:sous_chef_app/widgets/search_bar.dart';

class SavedTab extends StatelessWidget {
  SavedTab({super.key});

  //TODO: use database for this
  final List _recipes = [
    ["Pasta"],
    ["Roasted Broccoli"],
    ["Apple Pie"]
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Row(
            children: [
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
                    // TODO: clicking this adds custom recipe
                    onPressed: () {},
                    ),
                  ), 
                ), 
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
              const MyRadio(
                firstText: "Recent",
                firstWidth: 90,
                secondText: "A-Z",
                secondWidth: 55,
              ),
              const SizedBox(width:5), 
              SizedBox(
                width: 40,
                height: 40,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 230, 230, 230),
                    ),
                  child: IconButton(
                    icon: const Icon(Icons.tune_rounded),
                    iconSize: 25,
                    color: Colors.black,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(1),
                    // TODO: clicking this opens filter dialogue (can make, dietary, cusines)
                    onPressed: () {},
                  ), 
                ), 
              ),
            ],
          ),
          const SizedBox(height:20), 
          //inventory list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                return MySquare(
                  title: _recipes[index][0],
                  recipeDate:DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 
