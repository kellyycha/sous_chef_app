import 'package:flutter/material.dart';
import 'package:sous_chef_app/pages/inventory_page.dart';
import 'package:sous_chef_app/pages/calendar_page.dart';
import 'package:sous_chef_app/pages/recipes_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    InventoryPage(),
    const CalendarPage(),
    const RecipesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        // type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.storage_rounded),
            label: "Inventory",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: "Calendar",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories_rounded),
            label: "Recipes",
          ),
        ]
      )

    );
  }
}