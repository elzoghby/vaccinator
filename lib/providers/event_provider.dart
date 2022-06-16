
import 'package:flutter/material.dart';
import 'package:vaccinator/models/child_vaccine.dart';
import 'package:vaccinator/services/database_methods.dart';

import '../models/event.dart';

class EventProvider with ChangeNotifier {
  List<Event> events = [];
List <Event>allEvents=[];
  addEvent( Event event) async {
    await DatabaseMethods().addEvent(event);
    events.add(event);
  }
  fetchEvent(String id) async {
    events= await DatabaseMethods().getChildEvent(id);

  }
  getChildEvents(String id){
   List<Event>childEvents= allEvents.where((element) => element.childId==id).toList();
   childEvents.sort((a, b) => a.date.compareTo(b.date),);
   print(childEvents.length.toString()+'evvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
   return childEvents;
  }
  Future fetchAll() async {
    allEvents= await DatabaseMethods().getAllChildrenEvents();
    deleteMissed();
    print(allEvents.length.toString()+'ahmed');

  }
  deleteMissed() async {
    for (Event event in allEvents){
      if(DateTime.now().isAfter(event.date)){
        await DatabaseMethods().deleteGone(event.date);
        ChildVaccine childVaccine=ChildVaccine(childName: event.childName, vaccine: event.vaccineName);
        await DatabaseMethods().addVaccinationHistory(event.childId,childVaccine);
      }
    }
  }

}
