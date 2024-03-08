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
          weekDays: const ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
          eventsList: _expiratioList,
          isExpandable: true,
          eventColor: null,
          isExpanded: true,
          datePickerType: DatePickerType.date,
        ),
      ),
    );
  }
}

//sample data
// TODO: show picture, qty, remove timestamp, make title "Expiring + date"
final List<NeatCleanCalendarEvent> _expiratioList = [
  NeatCleanCalendarEvent('Apple',
    startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 5),
    endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 5),
  ),
  NeatCleanCalendarEvent('Broccoli',
    startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  ),
  NeatCleanCalendarEvent('Cabbage',
    startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
    endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
  ),
];