import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaccinator/models/event_data_source.dart';
import 'package:vaccinator/providers/event_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/event.dart';

class Calendar extends StatelessWidget {
  static String id = 'calendar';
  const Calendar({Key? key}) : super(key: key);
  // getDates(BuildContext context){
  //
  //
  //   for (Event event in events){
  //     print(event.date);
  //     CalendarControllerProvider.of(context).controller.add(CalendarEventData(
  //       date:event.date,color: Colors.teal,
  //       endDate: event.date.add(Duration(hours: 8)),
  //       //event: "Event 1",
  //       title: '${event.vaccineName}',
  //     ));
  //
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    List<Event>events=Provider.of<EventProvider>(context).allEvents;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Vaccines calendar'),centerTitle: true),
      body: SfCalendar(
        cellBorderColor: Colors.transparent,
        cellEndPadding: 0.0,
        initialDisplayDate: DateTime.now(),
        view: CalendarView.month,
        controller: CalendarController(),
      //  viewHeaderStyle: ViewHeaderStyle(backgroundColor: Colors.redAccent),
        showCurrentTimeIndicator: false,
        showDatePickerButton: false,
        showNavigationArrow: true,
        allowViewNavigation: false,
        
        //selectionDecoration: BoxDecoration(color: Colors.black),
headerStyle: CalendarHeaderStyle(textAlign: TextAlign.end),

        scheduleViewSettings: ScheduleViewSettings(monthHeaderSettings: MonthHeaderSettings(height: 50)),
        dataSource: EventDataSource(events),
      )
    );
  }
}
