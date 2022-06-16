import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vaccinator/models/child_vaccine.dart';
import 'package:vaccinator/pages/missed_vaccine_status_screen.dart';
import 'package:vaccinator/providers/child_vaccine_provider.dart';

import '../main.dart';
import '../models/child.dart';
import '../models/event.dart';
import '../models/vaccine.dart';
import '../pages/select_initial_reminders.dart';
import '../providers/childern_provider.dart';
import '../providers/event_provider.dart';
import '../providers/vaccine_provider.dart';
import 'home.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:uuid/uuid.dart';

String name = "";

DateTime? dob;
String? formattedDate;
int gender = -1;
String? service;
List<String> servicesList = ['home service', 'hospital'];

class AddChild extends StatefulWidget {
  @override
  _AddChildState createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showError = false;

  // Take Image from camera

// Take Image from gallery

  // Show Picker
  void scheduleAlarm(
      {required String vaccineName,
      required String service,
      required DateTime time}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif3',

      'Channel for Alarm notificationa',
      icon: 'alarm',
      fullScreenIntent: true,
      sound: RawResourceAndroidNotificationSound('alarm_song'),
      importance: Importance.max,
      visibility: NotificationVisibility.public,
      priority: Priority.max,

      //styleInformation: BigPictureStyleInformation(),
      largeIcon: DrawableResourceAndroidBitmap('alarm'),
    );

    // var iOSPlatformChannelSpecifics = IOSNotificationDetails(
    //   //  sound: 'a_long_cold_sting.wav',
    //     presentAlert: true,
    //     presentBadge: true,
    //     presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.schedule(
      0,
      vaccineName,
      service,
      time,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    );
  }

  getVaccines(DateTime birth, Child child) async {
    DateDuration age = AgeCalculator.age(birth);

    DateTime today = DateTime.now();

    int year = age.years;
    int month = age.months;
    int day = age.days;
    print(age);
    print(month);
    List<ChildVaccine> goneVaccines = [];
    List<ChildVaccine> nextVaccines = [];

    List<Vaccine> vaccines =
        Provider.of<Vaccines>(context, listen: false).vaccines;
    int order = 0;
    for (int i = 0; i < vaccines.length; i++) {
      if (DateTime.now().isAfter(birth.add(Duration(
        days: vaccines[i].day +
            (vaccines[i].month * 30) +
            (vaccines[i].year * 365),
      )))) {
         goneVaccines.add(ChildVaccine(
           childName: child.name, vaccine: vaccines[i].name, status: 1));

      } else {
        Event event = Event(
            order: order,
            childName: child.name,
            childId: child.id,
            date: birth.add(Duration(
              days: vaccines[i].day +
                  (vaccines[i].month * 30) +
                  (vaccines[i].year * 365),
            )),
            vaccineName: vaccines[i].name);
        await Provider.of<EventProvider>(context, listen: false)
            .addEvent(event);
        order++;
        // await Provider.of<ChildVaccinesProvider>(context, listen: false)
        // .addChildVaccine(child.id, ChildVaccine(
        //   childName: child.name, vaccine: vaccines[i].name, status: 0));
        scheduleAlarm(
          vaccineName: vaccines[i].name,
          service: child.service,
          time: birth.add(Duration(
            days: vaccines[i].day +
                (vaccines[i].month * 30) +
                (vaccines[i].year * 365),
          )),
        );
      }

      if(goneVaccines.isNotEmpty) {
        await Provider.of<ChildVaccinesProvider>(context,listen : false).addAllChildVaccine(child.id, goneVaccines);
      }

    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MissedVaccineScreen(
                  id: child.id,
                )));
  }

  // Widget for Child Name
  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
          key: Key("ChildName"),
          cursorColor: Colors.black,
          decoration: InputDecoration(labelText: "Child Name"),
          onSaved: (value) {
            name = value!;
          }),
    );
  }

  // void _goToSelectReminders(BuildContext context, Child newChild) async {
  //   Child result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => Select_Initial_Reminders(
  //         child: newChild,
  //       ),
  //     ),
  //   );
  //   Navigator.pop(context, result);
  // }

  @override
  void initState() {
    super.initState();
    name = "";
    dob = null;
    formattedDate = "";
    gender = -1;
  }

  var kidId = const Uuid().v4();

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(top: 50),
          child: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Child Details',
                    style: TextStyle(
                      color: Colors.cyan[900],
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              // Add an option to add Image

              // Add Name
              Container(
                  width: 98.w,
                  height: 48.h,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green[500]!, width: 2),
                    color: Colors.lightGreen[50],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(children: <Widget>[
                    _buildName(),
                    // Add date of birth through scrollable sat picker
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Date Of Birth'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(dob == null ? "" : formattedDate!),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green, // background
                            ),
                            child: Text('Pick a date'),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate:
                                          dob == null ? DateTime.now() : dob!,
                                      firstDate: DateTime(1990),
                                      lastDate: DateTime(2025))
                                  .then((date) {
                                setState(() {
                                  dob = date;
                                  formattedDate =
                                      "${date!.day} - ${date.month} - ${date.year}";
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    // Add the gender of child
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Gender'),
                          Text(
                            'Male',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Radio(
                            value: 0,
                            groupValue: gender,
                            onChanged: (int? value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                          Text(
                            'Female',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Radio(
                            value: 1,
                            groupValue: gender,
                            onChanged: (int? value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Text('Choose service',
                        style: TextStyle(color: Colors.red, fontSize: 18.sp)),
                    Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Row(
                        children: [
                          Text(service != null ? '' : 'Hospital'),
                          Expanded(
                            child: DropdownButton(
                              isDense: true,
                              underline: const SizedBox(),
                              iconSize: 20.sp,
                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.redAccent[700],
                              ),
                              borderRadius: BorderRadius.circular(15),
                              value: service,
                              onChanged: (newValue) {
                                setState(() {
                                  service = newValue.toString();
                                });
                              },
                              items: servicesList
                                  .map((value) => DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    if (service == servicesList[0])
                      Text('Home service will cost you 15\$',
                          style: TextStyle(color: Colors.red, fontSize: 18.sp)),
                  ])),

              // Next button - transfer the information
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // background
                    //onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () async {
                    _formKey.currentState!.save();
                    if (dob == null ||
                        gender == -1 ||
                        name == "" ||
                        service!.isEmpty) {
                      setState(() {
                        showError = true;
                      });
                      return;
                    }
                    showError = false;
                    Child newChild = Child(
                        service: service!,
                        id: kidId,
                        name: name,
                        gender: gender,
                        birthDay: dob!);
                    await Provider.of<ChildrenProvider>(context, listen: false)
                        .addChild(newChild);
                    getVaccines(dob!, newChild);
                  },
                  icon: Icon(Icons.arrow_forward_sharp),
                  label: Text(""),
                ),
              ),
              showError == true
                  ? Container(
                      padding: EdgeInsets.only(top: 20),
                      child: const Text(
                          " Fill in all the details before moving forward "),
                    )
                  : Container(),
            ]),
          ),
        ),
      )),
    );
  }
}
