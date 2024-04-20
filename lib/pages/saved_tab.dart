import 'package:flutter/material.dart';
import 'package:sous_chef_app/widgets/custom_radio.dart';
import 'package:sous_chef_app/widgets/custom_recipe.dart';
import 'package:sous_chef_app/widgets/item_square.dart';
import 'package:sous_chef_app/widgets/recipe_card.dart';
import 'package:sous_chef_app/widgets/search_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SavedTab extends StatefulWidget {
  const SavedTab({super.key});

  @override
  _savedTabState createState() => _savedTabState();
}


class _savedTabState extends State<SavedTab> {
  List<List<dynamic>> _recipes = [];
  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    try {
      //SERVER CHANGE API CALL
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/get_recipes/'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        jsonData.forEach((key, value) {
          String name = value['name'];
          DateTime dateSaved = DateTime.parse(value['date_saved']);
          String instructions = value['instructions'];
          String imageEncodedString = value['recipe_longtext'];

          List<dynamic> recipe = [
            name,
            instructions,
            imageEncodedString,
            dateSaved,
          ];
          print(recipe[0]);

          setState(() {
            _recipes.add(recipe);
          });
        });

      } else {
        throw Exception('Failed to load recipe data');
      }
    } catch (e) {
      print('Error fetching recipe data: $e');
    }
  }

  //TODO: use DB. [title, recipe (full string), image encoded string, date saved]

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
                              return const CustomRecipe();
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
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                // Stretch Goal: Gray out ones that user does not have ingredients for. Also filter with a "cookable" toggle.
                return MySquare(
                  title: _recipes[index][0],
                  img: _recipes[index][2],
                  recipeDate: _recipes[index][3],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeCard(
                          title: _recipes[index][0],
                          recipeResponse: _recipes[index][1],
                          image: _recipes[index][2], 
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
