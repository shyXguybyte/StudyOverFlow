import 'dart:core';

import 'package:flutter/material.dart';
import 'package:home_function/constants/calendar_settings.dart';
import 'package:home_function/models/meeting_data_source.dart';
import 'package:home_function/screens/home/widgets/add_appointment_dialog.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Appointment> _appointments = [];

  void _addAppointment(Appointment appointment) {
    setState(() {
      _appointments.add(appointment);
    });
  }

  void deleteEvent(Appointment appointment) {
    _appointments.remove(appointment);
  }

  void showEditEventDialog(Appointment appointment) {
    final titleController = TextEditingController(text: appointment.subject);
    final startHourController =
        TextEditingController(text: appointment.startTime.hour.toString());
    final startMinuteController =
        TextEditingController(text: appointment.startTime.minute.toString());
    final durationController = TextEditingController(
        text: appointment.endTime
            .difference(appointment.startTime)
            .inMinutes
            .toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Event'),
          content: Column(
            children: [
              // Input fields for editing (title, start hour, etc.)
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Event Title'),
              ),
              // Add other fields here
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save the updated event
                appointment.subject = titleController.text;
                appointment.startTime = appointment.startTime.copyWith(
                  hour: int.parse(startHourController.text),
                  minute: int.parse(startMinuteController.text),
                );
                appointment.endTime = appointment.startTime
                    .add(Duration(minutes: int.parse(durationController.text)));

                Navigator.of(context).pop(); // Close dialog
                setState(() {}); // Refresh UI
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      // Assuming your Appointment details and variables are the same
      final Appointment appointmentDetails = details.appointments![0];
      final String subject = appointmentDetails.subject;
      final String dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.startTime)
          .toString();
      final String startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.startTime).toString();
      final String endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
      final String timeDetails = '$startTimeText - $endTimeText';

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(subject),
            content: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dateText,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    timeDetails,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); //close the current dialog
                  showEditEventDialog(appointmentDetails);
                },
                child: Text('Edit Event'),
              ),
              TextButton(
                onPressed: () {
                  //to delete event
                  deleteEvent(appointmentDetails);
                  Navigator.of(context).pop();
                  //refresh the UI to reflect the deletion
                  setState(() {});
                },
                child: const Text(
                  "Delete Event",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Close"))
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Calendar"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                final newAppointment = await showDialog<Appointment>(
                  context: context,
                  builder: (context) => AddAppointmentDialog(),
                );
                if (newAppointment != null) {
                  _addAppointment(newAppointment);
                }
              },
            ),
          ],
        ),
        body: SfCalendar(
          view: CalendarView.week,
          dataSource: MeetingDataSource(_appointments),
          onTap: calendarTapped,
          firstDayOfWeek:
              CalendarSettings.defaultSettings['firstDayOfWeek'] as int,
          headerHeight:
              CalendarSettings.defaultSettings['headerHeight'] as double,
          todayHighlightColor:
              CalendarSettings.defaultSettings['todayHighlightColor'] as Color,
          viewNavigationMode: CalendarSettings
              .defaultSettings['viewNavigationMode'] as ViewNavigationMode,
          showCurrentTimeIndicator: CalendarSettings
              .defaultSettings['showCurrentTimeIndicator'] as bool,
          headerStyle: CalendarSettings.defaultSettings['headerStyle']
              as CalendarHeaderStyle,
          selectionDecoration: CalendarSettings
              .defaultSettings['selectionDecoration'] as BoxDecoration,
          appointmentTextStyle: CalendarSettings
              .defaultSettings['appointmentTextStyle'] as TextStyle,
          timeSlotViewSettings: CalendarSettings
              .defaultSettings['timeSlotViewSettings'] as TimeSlotViewSettings,
        ));
  }
}
