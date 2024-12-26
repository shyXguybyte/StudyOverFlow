import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarSettings {
  static final defaultSettings = {
    /** THESE 3 WILL BE FOUND IN THE MAIN FILE WHERE SfCalendar() EXISTS
          view: CalendarView.week,
          dataSource: MeetingDataSource(_appointments),
          onTap: calendarTapped,
    */
    'firstDayOfWeek': 6,
    'headerHeight': 30.0,
    'todayHighlightColor': const Color.fromARGB(255, 68, 140, 255),
    'viewNavigationMode': ViewNavigationMode.snap,
    'showCurrentTimeIndicator': false,
    'headerStyle': const CalendarHeaderStyle(
      textAlign: TextAlign.start,
      backgroundColor: Colors.white,
    ),
    'selectionDecoration': BoxDecoration(
      color: Colors.transparent,
      border: Border.all(
        color: const Color.fromARGB(255, 68, 140, 255),
        width: 2,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      shape: BoxShape.rectangle,
    ),
    'appointmentTextStyle': const TextStyle(
      fontSize: 7,
      color: Colors.white,
      letterSpacing: 1,
      fontWeight: FontWeight.bold,
    ),
    'timeSlotViewSettings': const TimeSlotViewSettings(
      startHour: 8,
      endHour: 24,
      timeIntervalHeight: 80,
      timeFormat: 'h a',
      dateFormat: 'd',
      dayFormat: 'E',
    ),
    "maxLine": 5,
    "minLine": 3
  };
}

 String getDayOfWeek(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return 'MO';
    case DateTime.tuesday:
      return 'TU';
    case DateTime.wednesday:
      return 'WE';
    case DateTime.thursday:
      return 'TH';
    case DateTime.friday:
      return 'FR';
    case DateTime.saturday:
      return 'SA';
    case DateTime.sunday:
      return 'SU';
    default:
      return '';
  }
}

