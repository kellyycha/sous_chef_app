import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecipeCard extends StatelessWidget {
  final String? recipeResponse;
  final String title;

  const RecipeCard({super.key, required this.recipeResponse, required this.title});

  @override
  Widget build(BuildContext context) {
    List<String> lines = recipeResponse!.split('\n');

    int ingredientsStartIndex = lines.indexOf('Ingredients:') + 1;
    int ingredientsEndIndex = lines.indexOf('Instructions:');
    List<String> ingredients = lines.sublist(ingredientsStartIndex, ingredientsEndIndex)
        .where((element) => element.trim().isNotEmpty)
        .map((ingredient) => ingredient.replaceAll(RegExp(r'^- '), ''))
        .toList();

    int instructionsStartIndex = ingredientsEndIndex + 1;
    List<String> instructions = lines.sublist(instructionsStartIndex)
        .where((element) => element.trim().isNotEmpty)
        .map((instruction) {
          return instruction.replaceAll(RegExp(r'^\d+\. '), '');
        })
        .toList();

    return Scaffold(
      appBar: AppBar(
      ),
      // TODO: add save button
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )
              ),
              const SizedBox(height: 8),
              const Text(
                'Ingredients:', 
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                )
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ingredients.map((ingredient) => ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                visualDensity: VisualDensity(vertical: -4),
                leading: Icon(Icons.circle, size: 10),
                title: Text(ingredient),
              )).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Instructions:', 
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                )
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: instructions.asMap().entries.map((entry) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 219, 235, 188),
                    foregroundColor: const Color.fromARGB(255, 67, 107, 31),
                    child: Text('${entry.key + 1}'),
                    ),
                  title: Text(entry.value),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
