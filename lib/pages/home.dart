import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vaccinator/models/event.dart';
import 'package:vaccinator/pages/children_history_screen/children_history_screen.dart';
import 'package:vaccinator/pages/events_screen/events_screen.dart';
import 'package:vaccinator/providers/event_provider.dart';
import 'package:vaccinator/services/database_methods.dart';

import '../models/child.dart';
import '../providers/childern_provider.dart';
import '../providers/vaccine_provider.dart';
import '../widgets/app_drawer.dart';
import 'addChild.dart';
import 'calendar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static String id = 'home';
  fetcher(BuildContext context) async {
    Provider.of<Vaccines>(context).getVaccines();
    Provider.of<EventProvider>(context).fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        Provider.of<ChildrenProvider>(context).fetchChildren(),
        Provider.of<Vaccines>(context).getVaccines(),
        Provider.of<EventProvider>(context).fetchAll()
      ]),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<Child> children =
              Provider.of<ChildrenProvider>(context).children;
          print(children.length.toString() +
              'sssssssssssssaaaaaaaaaaaaaaaaaaaaaaaaa');

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: Text('Vaccination Sechdular'),
              centerTitle: true,
            ),
            drawer: AppDrawer(),
            body: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    child: Container(
                        padding: EdgeInsets.only(bottom: 5.w),
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            image: DecorationImage(image: AssetImage('assets/mp.png')),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [
                                  0.1,
                                  0.4,
                                  0.8,
                                  0.9
                                ],
                                colors: [
                                  Colors.teal[50]!,
                                  Colors.teal[100]!,
                                  Colors.teal[300]!,
                                  Colors.teal[400]!
                                ]),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            )),
                        child: Center(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  children.length,
                                  (index) {
                                    List<Event> events =
                                        Provider.of<EventProvider>(context)
                                            .getChildEvents(children[index].id);
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(

                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.symmetric(horizontal: 3.w,vertical: 8.w),
                                                child: Icon(
                                                  children[index].gender == 0
                                                      ? Icons.male_rounded
                                                      : Icons.female_rounded,
                                                  color: Colors.redAccent,
                                                  size: 25.sp,
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:  EdgeInsets.symmetric(horizontal: 2.w),
                                                    child: Text(children[index].name,
                                                        style: TextStyle(
                                                            color: Colors.purple,
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                            FontWeight.bold)),
                                                  ),
                                                  SizedBox(height: 1.h,),
                                                  Text(
                                                      ' Events: ${events.length}',
                                                      style: TextStyle(
                                                          color: Colors.orange,
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                          FontWeight.bold))
                                                                                      ],
                                              ),

                                            ],
                                          ),
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.white.withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(3, 3), // changes position of shadow
                                                ),
                                              ],

                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          height: 15.h,
                                        ),
                                      ),
                                    );
                                  },
                                )),
                          ),
                        )),
                  ),
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconWidget(
                                tab: () async {
                                 //await DatabaseMethods().getAllChildrenEvents();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddChild(

                                          )));
                                },
                                iconData: Icons.add,
                                iconName: 'Add child'),
                            SizedBox(
                              height: 5.h,
                            ),
                            IconWidget(
                              tab: (){
                                Navigator.pushNamed(context, Calendar.id);
                              },
                                iconData: Icons.calendar_today_rounded,
                                iconName: 'Calendar view'),
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconWidget(
                              tab: (){
                                Navigator.pushNamed(context, ChildrenHistoryScreen.id);
                              },
                                iconData: Icons.list_alt_outlined,
                                iconName: 'View all'),
                            SizedBox(
                              height: 5.h,
                            ),
                            IconWidget(
                              tab: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EventsScreen(

                                        )));
                              },
                                iconData: Icons.event,
                                iconName: 'Events'),
                          ],
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
          );
        }
      },
    );
  }
}

class IconWidget extends StatelessWidget {
  IconWidget(
      {Key? key, required this.iconData, required this.iconName, this.tab})
      : super(key: key);
  IconData iconData;
  String iconName;
  final tab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tab,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.cyan, width: 3),
                borderRadius: BorderRadius.circular(50)),
            child: Icon(iconData, size: 25.sp,color: Colors.teal),
          ),
          Text(iconName),
        ],
      ),
    );
  }
}
