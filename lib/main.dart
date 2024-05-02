import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sous_chef_app/services/notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:sous_chef_app/bottom_nav.dart';
import 'package:sous_chef_app/pages/inventory_page.dart';
import 'package:sous_chef_app/pages/calendar_page.dart';
import 'package:sous_chef_app/pages/recipes_page.dart';
import 'package:sous_chef_app/pages/video_feed.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sous_chef_app/services/server.dart';
import 'dart:async';
import 'package:sous_chef_app/food_db.dart';
import 'package:sous_chef_app/recipe_db.dart';


Future<void> _fetchExpiringIngredients() async {
  try {
    final response = await http.get(Uri.parse('http://${Server.address}/inventory/'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      jsonData.forEach((key, value) {
        String name = value['name'];
        String expirationDate = value['expiration_date'];

        // Calculate days left from today to expiration date
        DateTime today = DateTime.now();
        DateTime expiryDate = DateTime.parse(expirationDate);
        int daysLeft = expiryDate.difference(today).inDays;

        // Schedule notification for ingredients expiring tomorrow
        if (daysLeft == 1) {
          List emojis = ["⚠️","😱","😵","😰","‼"];
          final random = Random();
          int randEmoji = random.nextInt(emojis.length);

          NotificationService().scheduleNotification(
            title: '${emojis[randEmoji]} Expiring Tomorrow ${emojis[randEmoji]}',
            body: 'Your $name is expiring tomorrow.', // Customize the body with ingredient name
            scheduledNotificationDateTime: expiryDate, // Notification on expiry date
          );
        }
      });
    } else {
      throw Exception('Failed to load inventory');
    }
  } catch (e) {
    print('Error fetching inventory: $e');
  }
}




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();
  tz.initializeTimeZones();

  await _fetchExpiringIngredients();

  Timer.periodic(const Duration(seconds: 5), (timer) {
    // Call your function here
    foodDB().fetchInventoryData();
    recipeDB().fetchRecipes();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BottomNav(),
      routes: {
        '/bottomnav': (context) => const BottomNav(),
        '/inventorypage': (context) => InventoryPage(), 
        '/calendarpage': (context) => const CalendarPage(),
        '/recipespage': (context) => const RecipesPage(),
        '/video': (context) => const VideoScreen(),
      },

    );
  }
}