import 'dart:core';

import 'package:flutter/material.dart';
import 'package:home_function/constants/calendar_settings.dart';
import 'package:home_function/utils/Colors.dart';
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

class AddAppointmentDialog extends StatefulWidget {
  @override
  State<AddAppointmentDialog> createState() => _AddAppointmentDialogState();
}

class _AddAppointmentDialogState extends State<AddAppointmentDialog> {
  final _titleController = TextEditingController();
  final _startHourController = TextEditingController();
  final _startMinuteController = TextEditingController();
  final _durationController = TextEditingController();
  DateTime _selectedDay = DateTime(2024, 12, 8);
  Color _selectedColor = electricBlue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add New Event"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: "Title"),
            ),
            TextButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDay,
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2025),
                );
                if (selectedDate != null) {
                  setState(() {
                    _selectedDay = selectedDate;
                  });
                }
              },
              child: Text(
                "📍 Select Date: ${_selectedDay.toLocal().toString().split(' ')[0]}",
              ),
              iconAlignment: IconAlignment.end,
            ),
            TextField(
              controller: _startHourController,
              decoration: InputDecoration(hintText: "Start Hour (8-11)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _startMinuteController,
              decoration: InputDecoration(hintText: "Start Minute (0-59)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _durationController,
              decoration: InputDecoration(hintText: "Duration (hours)"),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<Color>(
              value: _selectedColor,
              items: [
                DropdownMenuItem(
                  value: electricBlue,
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: electricBlue),
                      SizedBox(width: 8),
                      Text('Electric Blue'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: teaGreen,
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: teaGreen),
                      SizedBox(width: 8),
                      Text('Tea Green'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: cream,
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: cream),
                      SizedBox(width: 8),
                      Text('Cream'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: sunset,
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: sunset),
                      SizedBox(width: 8),
                      Text('Sunset'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: melon,
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: melon),
                      SizedBox(width: 8),
                      Text('Melon'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedColor = value!;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final title = _titleController.text;
            final startHour = int.tryParse(_startHourController.text);
            final startMinute = int.tryParse(_startMinuteController.text) ?? 0;
            final duration = int.tryParse(_durationController.text) ?? 1;

            if (title.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Event name cannot be empty!"),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            if (startHour == null || startHour < 0 || startHour > 23) {
              // Show error if the start hour is invalid
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Please enter a valid start hour (8-23)!"),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            if (startMinute < 0 || startMinute > 59) {
              // Show error if the start minute is invalid
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Please enter a valid start minute (0-59)!"),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            if (duration < 0) {
              // Show error if the duration is invalid (should be greater than 0)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text("Please enter a valid duration (greater than 0)!"),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            final startTime = DateTime(
              _selectedDay.year,
              _selectedDay.month,
              _selectedDay.day,
              startHour,
              startMinute,
            );
            final endTime = startTime.add(Duration(hours: duration));

            final appointment = Appointment(
              startTime: startTime,
              endTime: endTime,
              subject: title,
              color: _selectedColor,
            );

            Navigator.pop(context, appointment);
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

