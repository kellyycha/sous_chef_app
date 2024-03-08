import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
// https://github.com/rwbr/flutter_neat_and_clean_calendar

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Calendar(
          eventsList: _expirationList,
          isExpandable: true,
          isExpanded: true,
          // datePickerType: DatePickerType.date,
        ),
      ),
    );
  }
}

//sample data
final List<NeatCleanCalendarEvent> _expirationList = [
  NeatCleanCalendarEvent('Apple',
    expirationDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 5),
  ),
  NeatCleanCalendarEvent('Broccoli',
    expirationDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  ),
  NeatCleanCalendarEvent('Cabbage',
    expirationDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
  ),
  NeatCleanCalendarEvent('Tomato',
    expirationDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
  ),
];