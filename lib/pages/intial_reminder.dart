// getVaccines(DateTime birth) {
//   DateTime today = DateTime.now();
//   int year = today.year - birth.year;
//   int month = today.month - birth.month;
//   int day = today.day - birth.day;
//   print(birth.month);
//   if (year == 0 && month == 0 && day == 0) {
//
//     print('1');
//   }
//   else if (year == 0 && month <= 1 && day <= 14) {
//     print('2');
//   }
//   else if ((year == 0 && month==1   && day > 14)||(year==0&&month==2&&day<=13)) {
// print('3');
//   }
//   else if ((year == 0 && month==2   && day > 13)||(year==0&&month==3&&day<=12)) {
//     print('4 $month');
//   }
//   else if ((year == 0 && month==3   && day > 12)||(year==0&&month>3&&month<5)||(year==0&&month==5&&day<=26)) {
//     print('5');
//   }
//   else if ((year == 0 && month==5   && day > 26)||(year==0&&month>5&&month<8)||(year==0&&month==8&&day<=24)) {
//     print('6');
//   }
//   else if ((year == 0 && month==8   && day > 24)|(year==0&&month==9&&day<=26)) {
//     print('7');
//   }
//   else if ((year == 0 && month==9   && day > 26)||(year==0&&month>9&&month<11)||(year==0&&month==11&&day<=25)) {
//     print('8');
//   }
//   else if ((year == 0 && month==11   && day > 25)||(year==0&&month>11&&month<12)||(year==1&&month==0&&day==0)) {
//     //check
//     print('8');
//   }
//   else if ((year == 1 && month==1 )||(year==1&&month==2&&day<=23)) {
//     print('9');
//   }
//   else if ((year == 1 && month==2   && day > 23)||(year==1&&month>2&&month<5)||(year==1&&month==5&&day<=21)) {
//     print('10');
//   }
//   else if ((year == 1 && month==5   && day > 21)||(year==1&&month>5&&month<11)||(year==1&&month==11&&day<=29)) {
//     print('11');
//   }
//   else if ((year == 1 && month==11   && day > 29)||(year==1&&month>11)||(year>1&&year<3)||(year==3&&month==7&&day<=29)||(year==3&&month<7)) {
//     print('12');
//   }
//   else if ((year == 3 && month==7   && day > 29)||(year==3&&month>7&&month<11)||(year==11&&month==5&&day<=9)) {
//     print('13');
//   }
//   else{
//     print('14');
//   }
//   }