import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
//import 'package:sous_chef_app/sample_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sous_chef_app/services/server.dart';
// https://github.com/rwbr/flutter_neat_and_clean_calendar

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<NeatCleanCalendarEvent> _expirationList = [];

  @override
  void initState() {
    super.initState();
    _fetchExpirationEvents();
  }

  Future<void> _fetchExpirationEvents() async {
    try {
      final response = await http.get(Uri.parse('http://${Server.address}/inventory/'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List <NeatCleanCalendarEvent> events = [];

        jsonData.forEach((key, value) {
          // Parse individual item data and create NeatCleanCalendarEvent
          NeatCleanCalendarEvent event = NeatCleanCalendarEvent(
            id: value['id'],
            title: value['name'],
            qty: value['quantity'],
            expirationDate: DateTime.parse(value['expiration_date']),
            image: value['image_url'],
          );
          events.add(event);
        });

        // Update state with retrieved events
        setState(() {
          _expirationList = events;
        });
      } else {
        throw Exception('Failed to load inventory data');
      }
    } catch (e) {
      print('Error fetching inventory data: $e');
      // Handle error (e.g., show error message)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Calendar(
          eventsList: _expirationList,
          isExpandable: true,
          isExpanded: true,
          datePickerType: DatePickerType.date,
        ),
      ),
    );
  }
}