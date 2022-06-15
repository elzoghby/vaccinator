import 'dart:io';
import 'package:vaccinator/models/child_vaccine.dart';

import './vaccine.dart';

File childImage = new File('assets/child.jpg');

class customMaps {
  DateTime ?date;
  List<dynamic>? arr;

  customMaps(DateTime date, List<dynamic> arr) {
    this.date = date;
    this.arr = arr;
  }

  Map<String, dynamic> toJson() =>
      {
        'date': date,
        'arr': arr,
      };
}

class   Child {
  String id;
  String name;
  DateTime birthDay;
  int gender; // 0 for boy , 1 for girl
  String service;
List<ChildVaccine>?history;

  Child(
      {required this.name, required this.birthDay, required this.gender, required this.service,this.history,
        required this.id,
      });


}

