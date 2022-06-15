
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Event{
 int order;
  String vaccineName;
  String childName;
  DateTime date;
  String childId;
  bool every=false;
  Color color =Colors.orangeAccent;
  Event({required this.vaccineName,required this.date,required this.childId,required this.childName,required this.order});
}