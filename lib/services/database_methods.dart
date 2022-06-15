import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaccinator/models/child_vaccine.dart';
import 'package:vaccinator/models/vaccine.dart';

import '../models/child.dart';
import '../models/event.dart';

class DatabaseMethods {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  final CollectionReference refChildren = FirebaseFirestore.instance
      .collection('parent')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('children');
  final CollectionReference refVaccines =
      FirebaseFirestore.instance.collection('vaccines');
  final CollectionReference refChildVaccine =
      FirebaseFirestore.instance.collection('childVaccine');

  final CollectionReference refEvents = FirebaseFirestore.instance
      .collection('allEvent')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('events');

  addChild(Child child) async {
    try {
      await refChildren.add({
        'id': child.id,
        'name': child.name,
        'gender': child.gender.toString(),
        'birthday': child.birthDay.toIso8601String(),
        'service':child.service
      });
      return true;
    } catch (e) {
      return e;
    }
  }

  fetchChildernbase() async {
    QuerySnapshot snapshot = await refChildren.get();
    List<Child> children = [];
    for (var element in snapshot.docs) {
      Child child = Child(
        service: element['service'],
          name: element['name'],
          gender: int.parse(element['gender']),
          id: element['id'],
          birthDay: DateTime.parse(element['birthday']),
      history:await fetchVaccinationHistory(element['id']),
      );
      print(child.gender.toString() + 'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');

      children.add(child);
    }
    return children;
  }
  getAllChildrenEvents() async {
    QuerySnapshot snapshot = await refEvents.get();
    List<Event> events = [];
    for (var elemnt in snapshot.docs) {
      Event event = Event(
          order: int.parse(elemnt['order']),
          vaccineName: elemnt['name'],
          date: DateTime.parse(elemnt['date']),
          childId: elemnt['childId'],
          childName: elemnt['childName']);
      print(elemnt['childName']);
      events.add(event);
    }

    return events;
  }
  addEvent(Event event) async {
    await refEvents.add({
      'order': event.order.toString(),
      'name': event.vaccineName,
      'date': event.date.toIso8601String(),
      'childId': event.childId,
      'childName': event.childName,
    });
  }

  fetchVaccine() async {
    QuerySnapshot snapshot = await refVaccines.get();
    List<Vaccine> myList = [];
    for (var element in snapshot.docs) {
      // print(state);
      Vaccine vaccine = Vaccine(
          name: element['name'],
          year: int.parse(element['year']),
          month: int.parse(element['month']),
          day: int.parse(element['day']),
          description: element['desc'],
          price: int.parse(element['price']));
      myList.add(vaccine);
    }
    return myList;
  }

  addVaccinationHistory(String id, ChildVaccine childVaccine) async {
    await refChildVaccine.doc(id).collection('vaccines').add({
      'childName': childVaccine.childName,
      'vaccine': childVaccine.vaccine,
      'status': childVaccine.status,
      'time': Timestamp.now().toDate().toIso8601String(),
    });
  }

  addAllVaccinationHistory(String id, List<ChildVaccine> history) async {

    for (int i=0; i<history.length ;i++) {
      await refChildVaccine.doc(id).collection('vaccines').add({
        'childName': history[i].childName,
        'vaccine': history[i].vaccine,
        'status': history[i].status,
        'time': Timestamp.now().toDate().toIso8601String()
      });
    }
  }

  fetchVaccinationHistory(String id) async {
    QuerySnapshot historysnap = await refChildVaccine
        .doc(id)
        .collection('vaccines')
        .orderBy('time')
        .get();
    List<dynamic> history = historysnap.docs;
    List<ChildVaccine> _childHistory = [];
    for (int i = 0; i < history.length; i++) {
      ChildVaccine childVaccine = ChildVaccine(
          childName: history[i]['childName'],
          vaccine: history[i]['vaccine'],
          status: history[i]['status']);
      _childHistory.add(childVaccine);
      print(childVaccine.vaccine);
    }
    return _childHistory;
  }


  getChildEvent(String id) async {
    QuerySnapshot snapshot = await refEvents.where('id' == id).get();
    List<Event> events = [];
    for (var elemnt in snapshot.docs) {
      Event event = Event(
          order: int.parse(elemnt['order']),
          vaccineName: elemnt['name'],
          date: DateTime.parse(elemnt['date']),
          childId: elemnt['childId'],
          childName: elemnt['childName']);
      events.add(event);
    }
    return events;
  }



  deleteGone(DateTime dateTime) async {
    refEvents.where("date", isEqualTo: dateTime).get().then((value) {
      value.docs.forEach((element) {
       refEvents
            .doc(element.id)
            .delete()
            .then((value) {
          print("Success!");
        });
      });
    });
  }
}
