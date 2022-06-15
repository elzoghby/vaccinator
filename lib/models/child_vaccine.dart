import 'package:vaccinator/models/vaccine.dart';

class ChildVaccine{

  String childName;
  String vaccine;
  int ?status;

  ChildVaccine({required this.childName,required this.vaccine,this.status});
}