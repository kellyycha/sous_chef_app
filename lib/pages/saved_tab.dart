import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sous_chef_app/widgets/custom_radio.dart';
import 'package:sous_chef_app/widgets/custom_edit_recipe.dart';
import 'package:sous_chef_app/widgets/item_square.dart';
import 'package:sous_chef_app/widgets/recipe_card.dart';
import 'package:sous_chef_app/widgets/search_bar.dart';
import 'package:sous_chef_app/recipe_db.dart';

class SavedTab extends StatefulWidget {
  const SavedTab({super.key});

  @override
  _savedTabState createState() => _savedTabState();
}

class _savedTabState extends State<SavedTab> {
  String _searchQuery = '';
  recipeDB thisRecipeDB = recipeDB();
  String _sortBy = "Recent";

  @override
  void initState() {
    super.initState();
    setState(() {
      thisRecipeDB.fetchRecipes();
    });
    _refreshRecipeData();
  }

  Future<void> _refreshRecipeData() async {
    if (!mounted) return;

    await thisRecipeDB.fetchRecipes();

    if (mounted) {
      setState(() {});
    }
  } 


  void handleRecipeSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      recipes = allRecipes.where((recipe) {
        final recipeName = recipe[1].toLowerCase();
        return recipeName.contains(_searchQuery);
      }).toList();
      sortBy(_sortBy);
    });
  }

  void sortBy(String sortBy) {
    print(sortBy);
    if (sortBy == "Recent") {
      recipes.sort((a, b) => a[2].compareTo(b[2]));
    } else if (sortBy == 'A-Z') {
      recipes.sort((a, b) => a[1].toLowerCase().compareTo(b[1].toLowerCase()));
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
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: _refreshRecipeData,
        color: const Color.fromARGB(255, 67, 107, 31),
        child: Column(
          children: [
            const SizedBox(height:15),
            Row(
              children: [
                SizedBox(
                  width: 290,
                  height: 40,
                  child: MySearchBar(
                    onSearch: handleRecipeSearch,
                  ),
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
                  firstText: "Recent",
                  firstWidth: 90,
                  secondText: "A-Z",
                  secondWidth: 55,
                  onSortBy: handleSortBy,
                ),
                const SizedBox(width:5), 
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
                    id: recipes[index][0],
                    title: recipes[index][1],
                    img: recipes[index][3],
                    recipeDate: recipes[index][4],
                    cookable: recipes[index][5], 
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeCard(
                            id: recipes[index][0],
                            title: recipes[index][1],
                            recipeResponse: recipes[index][2],
                            image: recipes[index][3],
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
      )
    );
  }
} 
