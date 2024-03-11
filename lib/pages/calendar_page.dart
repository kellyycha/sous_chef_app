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
        ),
      ),
    );
  }
}

//sample data
final List<NeatCleanCalendarEvent> _expirationList = [
  NeatCleanCalendarEvent(
    title: 'Apple',
    qty: 1,
    expirationDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 5),
  ),
  NeatCleanCalendarEvent(
    title: 'Broccoli',
    qty: 2,
    expirationDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  ),
  NeatCleanCalendarEvent(
    title: 'Cabbage',
    qty: 2,
    expirationDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
  ),
  NeatCleanCalendarEvent(
    title: 'Tomato',
    qty: 4,
    expirationDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
  ),
  NeatCleanCalendarEvent(
    title: 'Orange',
    qty: 3,
    expirationDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
  ),
];