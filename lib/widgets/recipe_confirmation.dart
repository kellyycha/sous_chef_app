import 'package:flutter/material.dart';
import 'package:sous_chef_app/widgets/recipe_card.dart';

class RecipeConfirmation extends StatelessWidget {
  final String? recipeResponse;

  const RecipeConfirmation({super.key, required this.recipeResponse});

  @override
  Widget build(BuildContext context) {
    List<String> lines = recipeResponse!.split('\n');
    String title = lines.firstWhere((line) => line.trim().isNotEmpty, orElse: () => '');
      if (title.startsWith('-') && title.endsWith('-')) {
        title = title.substring(1, title.length - 1);
      }
      if (title.startsWith('**') && title.endsWith('**')) {
        title = title.substring(2, title.length - 2);
      }
      if (title.startsWith('Recipe:')) {
        title = title.substring(7).trim();
      }

    return AlertDialog(
      title: Text(title),
      backgroundColor: const Color.fromARGB(255, 219, 235, 188),

      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 230, 230, 230),), // Button color
          ),
          child: const Text(
            'Back',
            style: TextStyle(color: Colors.black),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipeCard(recipeResponse: recipeResponse, title: title)),
              );
            } catch (e) {
              print('Error: $e');
              // Handle error
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 67, 107, 31)), // Button color
          ),
          child: const Text(
            "Let's get cooking!",
            style: TextStyle(color: Colors.white),
          ),
        ),
        
      ],
    );
  }
}