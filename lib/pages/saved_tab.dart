import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sous_chef_app/widgets/custom_radio.dart';
import 'package:sous_chef_app/widgets/filter.dart';
import 'package:sous_chef_app/widgets/item_square.dart';
import 'package:sous_chef_app/widgets/recipe_card.dart';
import 'package:sous_chef_app/widgets/search_bar.dart';

class SavedTab extends StatelessWidget {
  SavedTab({super.key});

  //TODO: use database for this
  final List _recipes = [
    ["Garlic Lemon Broccoli Stir-Fry", 
"""Recipe: Garlic Lemon Broccoli Stir-Fry
Ingredients:
- Garlic, 2 cloves
- Lemon, 1
- Broccoli, 1
- Soy Sauce
- Salt
- Pepper
- Sesame Oil

Instructions:
1. Wash and cut the broccoli into florets.
2. Mince the garlic.
3. Heat some sesame oil in a pan over medium heat.
4. Add the minced garlic and stir for 1 minute until fragrant.
5. Add the broccoli to the pan and stir-fry for 5-7 minutes until slightly tender.
6. Squeeze the lemon juice over the broccoli.
7. Season with soy sauce, salt, and pepper to taste.
8. Stir well to combine all the flavors.
9. Cook for an additional 2-3 minutes until the broccoli is cooked to your desired tenderness.
10. Serve hot and enjoy""", null],
    ["Japanese Style Stir-Fried Vegetables with Steak",
"""Recipe: Japanese Style Stir-Fried Vegetables with Steak

Ingredients:
- Steak
- Mushroom
- Onion
- Garlic
- Carrot
- Soy Sauce
- Salt
- Pepper
- Sesame Oil

Instructions:
1. Slice the steak into thin strips.
2. Chop the mushrooms, onion, and garlic.
3. Peel and julienne the carrot.
4. In a large pan or wok, heat some sesame oil over medium-high heat.
5. Add the sliced steak strips and cook until browned.
6. Add the chopped mushrooms, onion, garlic, and julienned carrot to the pan.
7. Season with soy sauce, salt, and pepper to taste.
8. Stir-fry the ingredients until the vegetables are tender and the steak is cooked to your desired doneness.
9. Serve hot and enjoy your Japanese Style Stir-Fried Vegetables with Steak""", 
null],
    ["Indian Spiced Potato and Cauliflower Curry",
"""
Recipe: Indian Spiced Potato and Cauliflower Curry

Ingredients:
- Potato, 2
- Garlic, 2 cloves
- Cauliflower, 1
- Onion, 1
- Tomato, 2
- Cumin
- Coriander
- Turmeric
- Garam Masala
- Salt
- Pepper
- Oil

Instructions:
1. Peel and chop the potatoes into small cubes.
2. Cut the cauliflower into florets.
3. Heat oil in a large pan and sauté chopped garlic until fragrant.
4. Add chopped onion and cook until softened.
5. Stir in the diced tomatoes and cook until they break down.
6. Add the potatoes and cauliflower to the pan.
7. Season with cumin, coriander, turmeric, garam masala, salt, and pepper.
8. Cover and let the vegetables cook until tender, stirring occasionally.
9. Once the vegetables are cooked, garnish with fresh cilantro.
10. Serve the spiced potato and cauliflower curry hot with rice or naan. Enjoy your meal!
""", null]
    ];

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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FilterPopup();
                        },
                      ); 
                    },
                  ), 
                ), 
              ),
            ],
          ),
          const SizedBox(height:20), 
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                return MySquare(
                  title: _recipes[index][0],
                  recipeDate:DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                  img: _recipes[index][2],  
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
                  onDelete: () {  
                    // TODO: remove from database
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
