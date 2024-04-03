import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sous_chef_app/widgets/recipe_card.dart';
import 'package:sous_chef_app/widgets/recipe_confirmation.dart';
import 'package:sous_chef_app/services/openai/chat_service.dart';
import 'package:sous_chef_app/widgets/filter.dart';

final GlobalKey<FilterPopupState> filterPopupKey = GlobalKey<FilterPopupState>();

class GenerateTab extends StatefulWidget {
  const GenerateTab({super.key});

  @override
  State<GenerateTab> createState() => _GenerateState();
}

class _GenerateState extends State<GenerateTab> {
  bool _isPlaying = false;
  late final Future<LottieComposition> _composition;
  String? response;
  
  List<String> dietaryRestrictions = [];
  List<String> cuisines = [];

  // from DB
  List ingredients = [
    ["Tomato", "4/26/24"], 
    ["Potato", "5/2/24"],
    ["Garlic", "4/1/24"],
    ["Broccoli", "4/1/24"],
    ["Banana", "4/20/24"],
    ["Cabbage", "5/10/24"],
    ["Corn","5/10/24"],
    ["Eggplant", "5/10/24"],
    ["Lemon", "5/10/24"],
    ["Carrot","5/10/24"],
    ["Steak", "5/10/24"],
    ["Egg", "4/10/24"],
    ["Avocado", "5/10/24"],
    ["Onion", "5/10/24"],
    ["Orange", "5/10/24"],
    ["Scallion", "3/30/24"],
    ["Jalapeno","5/10/24"],
    ["Mushroom", "5/10/24"],
    ["Cauliflower", "5/10/24"],
    ["Soy Sauce", -1],
    ["Salt", -1],
    ["Pepper", -1],
    ["Paprika", -1],
    ["Cinnamon", -1],
    ["Vinegar", -1],
    ["Sesame Oil", -1],
    ["Chili Oil", -1],
    ["Parsley", -1],];



  @override
  void initState() {
    super.initState();

    _composition = AssetLottie('assets/animations/cooking2.json').load();
  }

  Future<String?> generateRecipe() async {
    String prompt = constructPrompt(ingredients, dietaryRestrictions, cuisines);

    response = await ChatService().request(prompt);

    //TODO: follow prompting flow (parse for ingredients here to check)

    return response;
  }

  String constructPrompt(List ingredients, List<String> dietaryRestrictions, List<String> cuisines) {
    String prompt = "Give me a recipe using a subset of these ingredients, given in a list of ingredients and their expiration date (assume values with -1 do not expire):\n\n";
    prompt += "${ingredients.join(', ')}\n";
    prompt += "You do not need to use all of the ingredients. Give higher priority to the ingredients that have sooner expiration dates.";
    if (dietaryRestrictions.isNotEmpty) {
      prompt += "Make sure the recipe follows these dietary restrictions: ${dietaryRestrictions.join(', ')}\n";
    }
    if (cuisines.isNotEmpty) {
      prompt += "Make sure the recipe if one of the following cuisines: ${cuisines.join(', ')}\n\n";
    }
    return prompt;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox( height: 100),
        _isPlaying ?
        FutureBuilder<LottieComposition>(
          future: _composition,
          builder: (context, snapshot) {
            var composition = snapshot.data;
            return Lottie(composition: composition);
          },
        )
        : Container(
          height: 202,
          padding:EdgeInsets.all(30),
          alignment: Alignment.center,
          child: const Text(
            'WARNING: Sous-Chef will try to recommend recipes that use ingredients expiring soon. Please check all ingredients for signs of rotting before use.',
            style: TextStyle(
              color:Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox( height: 50),
        Row(
          children: [
            const Spacer(),
            SizedBox(
              width: 200,
              height: 60,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 230, 230, 230),
                  ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      ),
                    backgroundColor: const Color.fromARGB(255, 67, 107, 31),
                    foregroundColor: Colors.white,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(1),
                  ),
                  onPressed: () async {
                    setState(() {
                      _isPlaying = true;
                    });

                    try {
                      String? recipeResponse = await generateRecipe();
                      setState(() {
                        _isPlaying = false;
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return RecipeConfirmation(recipeResponse: recipeResponse);
                        },
                      );
                    } catch (e) {
                      print('Error: $e');
                      // Handle error
                    }
                  },
                  child: const Text("Generate Recipe"),
                  ),
                ), 
              ),
              const SizedBox( width: 10), 
              SizedBox(
              width: 50,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 230, 230, 230),
                  ),
                child: IconButton(
                  icon: const Icon(Icons.tune_rounded),
                  iconSize: 30,
                  color: Colors.black,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(1),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return FilterPopup(
                          key: filterPopupKey,
                        );
                      },
                    ).then((value) {
                      dietaryRestrictions = filterPopupKey.currentState!.getSelectedDietaryRestrictions();
                      cuisines = filterPopupKey.currentState!.getSelectedCuisines();
                    });
                  },
                ), 
              ), 
            ),
            const Spacer(),
          ],
        ),
          
      ],
    );
  }
}
