import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../models/event.dart';
import '../../services/database_methods.dart';
import 'components/add_item_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);
  static const id = 'addProduct';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? name;
  String? description;
  int? price;
  String? category;
  List categoryMenu = ['Vegetables', 'Fruits', 'Spices'];
  int? year;
  int? month;
  int? day;

  void scheduleAlarm() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',

      'Channel for Alarm notification',
      icon: 'alarm',
     // sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      importance: Importance.max,
      largeIcon: DrawableResourceAndroidBitmap('alarm'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      //  sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(0, 'Office', 'title',
        DateTime.now().add(const Duration(seconds: 5)), platformChannelSpecifics, androidAllowWhileIdle: true,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              SizedBox(height: 4.w),
              AddProductFields(
                  hint: 'name',
                  lines: 1,
                  ontap: (value) {
                    name = value;
                  }),
              Padding(
                padding: EdgeInsets.all(10.sp),
                child: Container(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(25)),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    hint: Text(
                      'Select category',
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Theme.of(context).primaryColor),
                    ),
                    iconSize: 25.sp,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    isExpanded: true,
                    value: category,
                    onChanged: (newValue) {
                      setState(() {
                        category = newValue.toString();
                      });
                    },
                    items: categoryMenu
                        .map((value) => DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            ))
                        .toList(),
                  ),
                ),
              ),
              AddProductFields(
                  hint: 'year',
                  type: TextInputType.number,
                  lines: 1,
                  ontap: (value) {
                    year = int.tryParse(value);
                  }),
              AddProductFields(
                  hint: 'month',
                  type: TextInputType.number,
                  lines: 1,
                  ontap: (value) {
                    month = int.tryParse(value);
                  }),
              AddProductFields(
                  hint: 'day',
                  type: TextInputType.number,
                  lines: 1,
                  ontap: (value) {
                    day = int.tryParse(value);
                  }),
              AddProductFields(
                  hint: 'description',
                  lines: 4,
                  ontap: (value) {
                    description = value;
                  }),
              AddProductFields(
                  hint: 'price',
                  type: TextInputType.number,
                  lines: 1,
                  ontap: (value) {
                    price = int.tryParse(value);
                  }),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.all(3.w),
                child: MaterialButton(
                  padding: EdgeInsets.all(4.w),
                  onPressed: () async {
                    if (name == null || price == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'please fill all the fields and add an image',
                            style: TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      );
                    } else {
                      scheduleAlarm();
                    }
                  },
                  minWidth: double.infinity / 2,
                  color: Colors.tealAccent,
                  child: Text('add item',
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black54,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
