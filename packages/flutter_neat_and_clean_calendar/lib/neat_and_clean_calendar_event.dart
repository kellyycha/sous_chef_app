import 'package:flutter/material.dart';

enum MultiDaySegement {
  first,
  middle,
  last,
}

class NeatCleanCalendarEvent {
  String summary;
  String description;
  String location;
  DateTime expirationDate;
  Color? color;
  bool isAllDay;
  bool isMultiDay;
  MultiDaySegement? multiDaySegement;
  bool isDone;
  Map<String, dynamic>? metadata;
  String? icon;
  bool? wide = false;

  NeatCleanCalendarEvent(
    this.summary, {
    this.description = '',
    this.location = '',
    required this.expirationDate,
    this.color = const Color.fromARGB(255, 67, 107, 31),
    this.isAllDay = false,
    this.isMultiDay = false,
    this.isDone = false,
    multiDaySegement,
    this.metadata,
    this.icon,
    this.wide,
  });
}
