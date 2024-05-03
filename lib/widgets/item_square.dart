import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sous_chef_app/food_db.dart';
import 'package:sous_chef_app/recipe_db.dart';
import 'package:sous_chef_app/services/image_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sous_chef_app/services/server.dart';

class MySquare extends StatelessWidget {
  final int id;
  final String title;
  final int? qty;
  final String? img;
  final int? expiration;
  final DateTime? recipeDate;
  final VoidCallback? onTap;
  final bool? cookable;

  const MySquare({
    super.key,
    required this.id,
    required this.title,
    this.qty,
    this.img,
    this.expiration,
    this.recipeDate,
    this.onTap,
    this.cookable
  });


  Future<void> deleteIngredient() async {
    try {
      final deleteQuery = "http://${Server.address}/delete_food/$id";
      final response = await http.delete(Uri.parse(deleteQuery));

      inventory.removeWhere((item) => item[0] == id);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print(jsonData);
      } else {
        throw Exception('Failed to delete Ingredient'); 
      }
    } catch (e) {
      print('Error deleting ingredient: $e');
    }
  }

  Future<void> deleteRecipe() async {
    try {
      final deleteQuery = "http://${Server.address}/remove_recipe/$id";
      final response = await http.delete(Uri.parse(deleteQuery));
      recipes.removeWhere((item) => item[0] == id);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print(jsonData);
      } else {
        throw Exception('Failed to delete Recipe');
      }
    } catch (e) {
      print('Error deleting recipe: $e');
    }
  }

  void onDelete() {
    print(title);
    print(id);
    // need to know which table to delete from...
    if (qty != null) { // ingredient
      deleteIngredient();
    } else { // recipe
      deleteRecipe();
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageHelper = ImageHelper();
    return GestureDetector(
      onTap: onTap,
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (_) => onDelete(), 
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20.0),
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              height: 120,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 243, 237),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color.fromARGB(255, 230, 230, 230)),
              ),
              child: Row(
                children: [
                  // image
                  (img == null || img == "") ? 
                  Container(
                    height: 120,
                    width: 150,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          bottomLeft: Radius.circular(24),
                        )),
                    child: const Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 50,
                      color: Colors.grey,
                    ),
                  )
                  : ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), bottomLeft: Radius.circular(24),),
                    child: imageHelper.getImageWidget(
                      image: img,
                      height: 120,
                      width: 150,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: qty != null ? 20 : 13, left: 20),
                        child: SizedBox(
                          width: qty != null ? 120 : 170,
                          child: Text(
                            title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: qty != null ? 20 : 16,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ),
                      Container(
                        child: expiration != null && expiration != -1
                            ? Padding(
                                padding: const EdgeInsets.only(top: 5, left: 20),
                                child: SizedBox(
                                  width: 120,
                                  child: Text(
                                    "$expiration days",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 66, 107, 31),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                      Container(
                        child: recipeDate != null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 5, left: 20),
                                child: SizedBox(
                                  width: 170,
                                  child: Text(
                                    "Saved ${DateFormat('M/d').format(recipeDate!)}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: qty != null ? 20 : 16,
                                      color: const Color.fromARGB(255, 66, 107, 31),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    child: qty != null && qty != -1
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20, right: 20),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "x$qty",
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  const SizedBox(width: 0),
                ],
              ),
            ),
            (cookable != null && cookable == false) ?
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              height: 120,
              decoration: BoxDecoration(
                color: const Color.fromARGB(122, 239, 239, 239),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color.fromARGB(255, 230, 230, 230)),
              ),
            ) 
            : Container(),
          ]
        ),
      ),
    );
  }
}
