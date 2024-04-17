import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sous_chef_app/services/openai/image_service.dart';
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
  bool _requestInProgress = false;
  late final Future<LottieComposition> _composition;
  String? response;
  
  List<String> dietaryRestrictions = [];
  List<String> cuisines = [];
  String? timing;

  // TODO: from DB. [ingredient, qty, expiration]
  List ingredients = [
    ["Tomato", 3, "4/26/24"], 
    ["Potato", 2, "5/2/24"],
    ["Garlic", 6, "4/1/24"],
    ["Broccoli", 4, "4/1/24"],
    ["Banana", 5, "4/20/24"],
    ["Cabbage", 1, "5/10/24"],
    ["Corn", 1, "5/10/24"],
    ["Eggplant", 2, "5/10/24"],
    ["Lemon", 4, "5/10/24"],
    ["Carrot", 10, "5/10/24"],
    ["Steak", 2, "5/10/24"],
    ["Egg", 12, "4/10/24"],
    ["Avocado", 4, "5/10/24"],
    ["Onion", 6, "5/10/24"],
    ["Orange", 2, "5/10/24"],
    ["Scallion", 11, "3/30/24"],
    ["Jalapeno", 8, "5/10/24"],
    ["Mushroom", 4, "5/10/24"],
    ["Cauliflower", 1, "5/10/24"],
    ["Soy Sauce", -1, -1],
    ["Salt", -1, -1],
    ["Pepper", -1, -1],
    ["Paprika", -1, -1],
    ["Cinnamon", -1, -1],
    ["Vinegar", -1, -1],
    ["Sesame Oil", -1, -1],
    ["Chili Oil", -1, -1],
    ["Parsley", -1, -1],];



  @override
  void initState() {
    super.initState();
    _composition = AssetLottie('assets/animations/cooking.json').load();
  }

    Future<String?> generateImage(recipeResponse) async {
    try {
      final imageUrl = await OpenAI().generateImageUrl(
        prompt: "a photograph of this dish: $recipeResponse",
      );
      print(imageUrl);

      setState(() {
        _requestInProgress = false;
      });

      return imageUrl;
      
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }

  Future<String?> generateRecipe() async {
    setState(() {
      _requestInProgress = true;
    });

    String prompt = constructPrompt(ingredients, dietaryRestrictions, cuisines, timing);
    String? response = await ChatService().request(prompt);

    // Loop requesting new prompts until "!!!" is found in the response
    while (response == null || !response.contains("!!!")) {
      response = await ChatService().request(prompt);
    }
    print(response);
    
    int indexOfEnd = response.indexOf("!!!");

    String recipeResponse = response.substring(0, indexOfEnd);

    // Let animation play
    // await Future.delayed(const Duration(seconds: 16));

    return recipeResponse;
  }

  String constructPrompt(List ingredients, List<String> dietaryRestrictions, List<String> cuisines, String? timing) {
    String prompt = "Give me a recipe using a subset of these ingredients, given in a list of ingredients, their quantities, and their expiration date (assume values with -1 have unlimited quantity and do not expire):\n\n";
    prompt += "${ingredients.join(', ')}\n";
    prompt += "You do not need to use all of the ingredients. Give higher priority to the ingredients that have sooner expiration dates.";
    if (dietaryRestrictions.isNotEmpty) {
      prompt += "Make sure the recipe follows these dietary restrictions: ${dietaryRestrictions.join(', ')}\n";
    }
    if (cuisines.isNotEmpty) {
      prompt += "Make sure the recipe if one of the following cuisines: ${cuisines.join(', ')}\n\n";
    }
    if (timing != null) {
      prompt += "Make sure the recipe takes under $timing, which includes time to prep ingredients and cook.\n\n";
    } 
    prompt += "Give the name of the recipe, label an Ingredients section where you will list the ingredients and the amount needed in the recipe, and label an Instructions section where you will list the steps of the recipe";
    prompt += "Denote the end of the recipe with '!!!', after the last step in the instructions.";
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
          padding: const EdgeInsets.all(30),
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
                  onPressed: _requestInProgress ? null : () async {
                    setState(() {
                      _isPlaying = true;
                    });

                    try {
                      String? recipeResponse = await generateRecipe();
                      String? imageResponse = await generateImage(recipeResponse);

                      setState(() {
                        _isPlaying = false;
                      });
                      
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // Stretch goal: pass in the Dietary Restrictions and Cuisine values to filter the saved recipes
                          return RecipeConfirmation(
                            recipeResponse: recipeResponse,
                            imageResponse: imageResponse,
                            );
                        },
                      );
                    } catch (e) {
                      print('Error: $e');
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
                      timing = filterPopupKey.currentState!.getSelectedTiming(); 
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
