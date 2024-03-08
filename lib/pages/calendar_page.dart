import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

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
          eventDoneColor: const Color.fromARGB(255, 67, 107, 31),
          selectedColor: const Color.fromARGB(255, 67, 107, 31),
          selectedTodayColor: const Color.fromARGB(255, 67, 107, 31),
          todayColor: const Color.fromARGB(255, 67, 107, 31),
          eventColor: null,
          isExpanded: true,
          datePickerType: DatePickerType.date,
          dayOfWeekStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.add),
      //   backgroundColor: Colors.green,
      // ),
    );
  }
}

//sample data
final List<NeatCleanCalendarEvent> _expirationList = [
  NeatCleanCalendarEvent('Apple',
      startTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 10, 0),
      endTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + 2, 12, 0),
      color: Colors.orange,
      isMultiDay: true),
  NeatCleanCalendarEvent('Broccoli',
      startTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day - 2, 14, 30),
      endTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + 2, 17, 0),
      color: Colors.pink,
      isAllDay: true),
  NeatCleanCalendarEvent('Cabbage',
      startTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 14, 30),
      endTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 17, 0),
      color: Colors.indigo),
];