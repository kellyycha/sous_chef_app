import 'package:flutter/material.dart';

class NeatCleanCalendarEvent {
  String title;
  int qty;
  DateTime expirationDate;
  Color? color;

  NeatCleanCalendarEvent({
    required this.title, 
    required this.qty,
    required this.expirationDate,
    this.color = const Color.fromARGB(255, 67, 107, 31),
  });
}
