import 'package:http/http.dart' as http;
import 'package:sous_chef_app/services/server.dart';
import 'dart:convert';

List<List<dynamic>> allRecipes = [];
List<List<dynamic>> recipes = [];

class recipeDB {
  Future<void> fetchRecipes() async {
    try {
      final response = await http.get(Uri.parse('http://${Server.address}/get_recipes/'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        allRecipes.clear();
        recipes.clear();
        jsonData.forEach((key, value) {
          int id = value['id'];
          String name = value['name'];
          DateTime dateSaved = DateTime.parse(value['date_saved']);
          String instructions = value['instructions'];
          String imageEncodedString = value['recipe_longtext'];
          bool cookable = value['cookable'];

          List<dynamic> recipe = [
            id,
            name,
            instructions,
            imageEncodedString,
            dateSaved,
            cookable,
          ];


          allRecipes.add(recipe);
          recipes.add(recipe);
        });

      } else {
        throw Exception('Failed to load recipe data');
      }
    } catch (e) {
      print('Error fetching recipe data: $e');
    }
  }
}