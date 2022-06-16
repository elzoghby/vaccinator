
import 'package:flutter/material.dart';
import 'package:vaccinator/services/database_methods.dart';

import '../models/child_vaccine.dart';
import '../models/vaccine.dart';

class ChildVaccinesProvider with ChangeNotifier{

  List<ChildVaccine> allChildrenVaccines=[];
  List<ChildVaccine>missedVaccines=[];
  List<ChildVaccine> childVaccines=[];
addChildVaccine(String id,ChildVaccine childVaccine)async{

await DatabaseMethods().addVaccinationHistory(id, childVaccine);
  allChildrenVaccines.add(childVaccine);

}
  Future<Iterable<Future>?>fetchHistory(String id)async{
childVaccines=  await DatabaseMethods().fetchVaccinationHistory(id);
return null;
}

  addAllChildVaccine(String id,List<ChildVaccine> history)async{
    await DatabaseMethods().addAllVaccinationHistory(id, history);
    allChildrenVaccines.addAll(history);

  }
}