import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vaccinator/pages/addChild.dart';
import 'package:vaccinator/pages/additemscreen/add_item_screen.dart';
import 'package:vaccinator/pages/calendar.dart';
import 'package:vaccinator/pages/children_history_screen/children_history_screen.dart';

import 'package:vaccinator/pages/home.dart';
import 'package:vaccinator/pages/home.dart';

import 'package:vaccinator/pages/signUp_screen.dart';
import 'package:vaccinator/pages/vaccines_screen/vaccines_screen.dart';
import 'package:vaccinator/providers/child_vaccine_provider.dart';
import 'package:vaccinator/providers/childern_provider.dart';
import 'package:vaccinator/providers/event_provider.dart';
import 'package:vaccinator/providers/vaccine_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future main() async {
   WidgetsFlutterBinding.ensureInitialized();
   var initializationSettingsAndroid =
   AndroidInitializationSettings('alarm');
   var initializationSettingsIOS = IOSInitializationSettings(
       requestAlertPermission: true,
       requestBadgePermission: true,
       requestSoundPermission: true,
       onDidReceiveLocalNotification:
           (int? id, String? title, String? body, String? payload) async {});
   var initializationSettings = InitializationSettings(
       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
       onSelectNotification: (String ?payload) async {
         if (payload != null) {
           debugPrint('notification payload: ' + payload);
         }
       });
   await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChildrenProvider()),
        ChangeNotifierProvider(create: (context) => Vaccines()),
        ChangeNotifierProvider(create: (context) => ChildVaccinesProvider()),
        ChangeNotifierProvider(create: (context) => EventProvider()),
      ],
      child: MaterialApp(

          title: 'VACCINATOR',
          home: ResponsiveSizer(builder: (context, orientation, deviceType)=>StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),

            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasData ) {
                  return Home();
                } else {
                  return SignUpScreen();
                }

          },)),
          debugShowCheckedModeBanner: false,

          routes: {
            Home.id: (context) => const Home(),
            Calendar.id: (context) => Calendar(),
            ChildrenHistoryScreen.id: (context) => const ChildrenHistoryScreen(),
            VaccinesScreen.id: (context) => const VaccinesScreen(),
            AddProduct.id: (context) => const AddProduct(),
          },
          ),
    );
  }
}


