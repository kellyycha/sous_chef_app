import 'package:flutter/material.dart';
import 'package:sous_chef_app/bottom_nav.dart';
import 'package:sous_chef_app/pages/inventory_page.dart';
import 'package:sous_chef_app/pages/calendar_page.dart';
import 'package:sous_chef_app/pages/recipes_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNav(),
      routes: {
        '/bottomnav': (context) => BottomNav(),
        '/inventorypage': (context) => InventoryPage(), 
        '/calendarpage': (context) => CalendarPage(),
        '/recipespage': (context) => RecipesPage(),
      }

    );
  }
}  