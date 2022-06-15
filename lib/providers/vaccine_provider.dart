import 'package:flutter/cupertino.dart';
import 'package:vaccinator/models/vaccine.dart';
import 'package:vaccinator/services/database_methods.dart';

class Vaccines with ChangeNotifier{
List<Vaccine> _vaccines=[];
List<Vaccine>get vaccines{
  return[..._vaccines];
}
Future<void>getVaccines()async{
_vaccines=await DatabaseMethods().fetchVaccine();
print(_vaccines.length.toString()+'mai');
}

}