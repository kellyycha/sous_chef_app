import 'package:flutter/material.dart';
import 'package:sous_chef_app/widgets/custom_radio.dart';
import 'package:sous_chef_app/widgets/custom_edit_recipe.dart';
import 'package:sous_chef_app/widgets/item_square.dart';
import 'package:sous_chef_app/widgets/recipe_card.dart';
import 'package:sous_chef_app/widgets/search_bar.dart';
import 'package:sous_chef_app/sample_data.dart';

class SavedTab extends StatelessWidget {
  SavedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const SizedBox(height:15),
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
                    onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomRecipe();
                            },
                          );
                        },
                    ),
                  ), 
                ), 
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
                firstText: "Recent",
                firstWidth: 90,
                secondText: "A-Z",
                secondWidth: 55,
              ),
              SizedBox(width:5), 
              // Stretch Goal: filter saved recipes (need to save the tags/ add tags to custom)
              // SizedBox(
              //   width: 40,
              //   height: 40,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(30),
              //       color: const Color.fromARGB(255, 230, 230, 230),
              //       ),
              //     child: IconButton(
              //       icon: const Icon(Icons.tune_rounded),
              //       iconSize: 25,
              //       color: Colors.black,
              //       alignment: Alignment.center,
              //       padding: const EdgeInsets.all(1),
              //       onPressed: () {
              //         showDialog(
              //           context: context,
              //           builder: (BuildContext context) {
              //             return const FilterPopup();
              //           },
              //         ); 
              //       },
              //     ), 
              //   ), 
              // ),
            ],
          ),
          const SizedBox(height:20), 
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                // Stretch Goal: Gray out ones that user does not have ingredients for. Also filter with a "cookable" toggle.
                return MySquare(
                  title: recipes[index][0],
                  img: recipes[index][2],
                  recipeDate: recipes[index][3],
                  cookable: recipes[index][4], // TODO: all this from DB
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeCard(
                          title: recipes[index][0],
                          recipeResponse: recipes[index][1],
                          image: recipes[index][2], 
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 
