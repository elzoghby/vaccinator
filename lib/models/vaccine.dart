// class Dose {
//   int ?position;
//   int ?week;
//   bool ?isNormal;
//   bool ?setReminder;
//
//   Dose(int position, int week, bool isNormal, bool setReminder) {
//     this.isNormal = isNormal;
//     this.week = week;
//     this.setReminder = setReminder;
//     this.position = position;
//   }
// }

class Vaccine {
  String name;
  int year;
  int month;
  int day;
  String description;
  // List of doses where each dose is described by the number of weeks after which it should be given
  // and boolean variable which denotes special prescription is required or not
  // True - normal , False = Only for specific children
  int ?price;

  Vaccine({required this.name,required this.year,required this.month,required this.day,required this.description,this.price});

}
