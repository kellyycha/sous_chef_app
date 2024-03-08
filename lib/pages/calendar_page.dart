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
          eventsList: _expirationList,
          isExpandable: true,
          eventDoneColor: const Color.fromARGB(155, 67, 107, 31),
          selectedColor: const Color.fromARGB(155, 67, 107, 31),
          selectedTodayColor: const Color.fromARGB(255, 67, 107, 31),
          todayColor: const Color.fromARGB(255, 67, 107, 31),
          eventColor: null,
          isExpanded: true,
          datePickerType: DatePickerType.date,
          dayOfWeekStyle: const TextStyle(
            color: Color.fromARGB(155, 67, 107, 31),),
          displayMonthTextStyle: const TextStyle(
            color: Color.fromARGB(255, 67, 107, 31),
            fontSize: 40.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Italiana',
          ),
        ),
      ),
    );
  }
}

//sample data
// TODO: show picture, qty, remove timestamp, make title "Expiring + date"
// Maybe copy and paste code instead of using package to cutomize the listview
final List<NeatCleanCalendarEvent> _expirationList = [
  NeatCleanCalendarEvent('Apple',
    startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 5),
    endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 5),
    color: const Color.fromARGB(155, 67, 107, 31),
  ),
  NeatCleanCalendarEvent('Broccoli',
    startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 8),
    endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 8),
    color: const Color.fromARGB(155, 67, 107, 31),
  ),
  NeatCleanCalendarEvent('Cabbage',
    startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
    endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
    color: const Color.fromARGB(155, 67, 107, 31),
  ),
];