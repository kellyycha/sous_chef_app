import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:sous_chef_app/sample_data.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Calendar(
          eventsList: expirationList,
          isExpandable: true,
          isExpanded: true,
          datePickerType: DatePickerType.date,
        ),
      ),
    );
  }
}