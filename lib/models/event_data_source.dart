import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'event.dart';

class EventDataSource extends CalendarDataSource{



  EventDataSource(List<Event> appointments) { this.appointments = appointments;

  }

  Event getEvent(int index) => appointments! [index] as Event;

  @override

  DateTime getStartTime(int index) => getEvent(index).date;

  @override

  DateTime getEndTime (int index) => getEvent(index).date.add(Duration(hours: 5,));

  @override

  String getSubject(int index) => getEvent(index).vaccineName;
  @override

  Color getColor(int index) => getEvent(index).color;
  @override

  bool isAllDay(int index)=> getEvent(index).every;
}