import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vaccinator/models/child.dart';
import 'package:vaccinator/providers/childern_provider.dart';
import 'package:intl/intl.dart';
import '../../models/event.dart';
import '../../providers/event_provider.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 List<Child>children= Provider.of<ChildrenProvider>(context).children;
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.teal,
      title: Text('Events',),
      centerTitle: true,
    ),body: SingleChildScrollView(
      child:Column(children:List.generate(children.length, (index) {
        List<Event> events =
        Provider.of<EventProvider>(context)
            .getChildEvents(children[index].id);
        return Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    children[index].name,
                    style: TextStyle(
                      fontSize: 18.sp,color: Colors.teal,

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                  DateFormat('dd/MM/yyyy').format(children[index].birthDay),
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  events.length,
                      (i) => Container(
                    margin: EdgeInsets.all(3.w),
                    height: 30.h,
                    width: 20.h,
                    padding: EdgeInsets.all(0.5.w),
                    decoration: BoxDecoration(
                       boxShadow: [
                    BoxShadow(
                    color: Colors.teal.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(3, 3), // changes position of shadow
                      ),
                    ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        GestureDetector(
                          onTap: () {

                          },
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/iconev.png',
                                  fit: BoxFit.contain,
                                  width: 28.w,
                                  height: 18.h,
                                ),
                              ),
                              Text(
                                events[i].vaccineName,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(   DateFormat('dd/MM/yyyy hh:mm').format(events[i].date),
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Theme.of(context).shadowColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                ),
              ),
            ),
          ],
        );
    })
      ),
    ),);
  }
}
