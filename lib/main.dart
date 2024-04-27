import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sous_chef_app/services/notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:sous_chef_app/bottom_nav.dart';
import 'package:sous_chef_app/pages/inventory_page.dart';
import 'package:sous_chef_app/pages/calendar_page.dart';
import 'package:sous_chef_app/pages/recipes_page.dart';
import 'package:sous_chef_app/pages/video_feed.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();
  tz.initializeTimeZones();

  // TODO: check which dates from the db are 1 day later.
  
  List emojis = ["⚠️","😱","😵","😰","‼"];
  final random = Random();
  int randEmoji = random.nextInt(emojis.length);

  NotificationService().scheduleNotification(
    title: '${emojis[randEmoji]} Expiring Tomorrow ${emojis[randEmoji]}',
    body: 'Banana', // combine all the items into one text
    scheduledNotificationDateTime: DateTime.now().add(Duration(seconds:30)) // today at a certain time
  );
  print("notif scheduled");

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