import 'dart:core';

import 'package:flutter/material.dart';
import 'package:home_function/utils/Colors.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Appointment> _appointments = [
    // Appointment(
    //   startTime: DateTime.now(),
    //   endTime: DateTime.now().add(Duration(hours: 2)),
    //   subject: 'Test Event',
    //   color: Colors.green,
    // ),
    // Appointment(
    //   startTime: DateTime.now().add(Duration(hours: 2)),
    //   endTime: DateTime.now().add(Duration(hours: 4)),
    //   subject: 'Test Event 2',
    //   color: const Color.fromARGB(255, 86, 76, 175),
    // ),
  ];

  void _addAppointment(Appointment appointment) {
    setState(() {
      _appointments.add(appointment);
    });
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
    final String timeDetails =  '$startTimeText - $endTimeText';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(subject),
          content: SizedBox(
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  dateText,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10), // Adding spacing between elements
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
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
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
        firstDayOfWeek: 6,
        headerHeight: 30,
        todayHighlightColor: Color.fromARGB(255, 68, 140, 255),
        viewNavigationMode: ViewNavigationMode.none,
        showCurrentTimeIndicator: false,
        headerStyle: CalendarHeaderStyle(
            textAlign: TextAlign.start, backgroundColor: Colors.white),
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              color: const Color.fromARGB(255, 68, 140, 255), width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          shape: BoxShape.rectangle,
        ),
        dataSource: MeetingDataSource(_appointments),
        appointmentTextStyle: const TextStyle(
          fontSize: 7,
          color: Colors.white,
          letterSpacing: 1,
          fontWeight: FontWeight.bold,
        ),
        timeSlotViewSettings: TimeSlotViewSettings(
          startHour: 8,
          endHour: 24,
          timeIntervalHeight: 80,
          timeFormat: 'h a',
          dateFormat: 'd',
          dayFormat: 'E',
        ),
        onTap: calendarTapped,
      ),
    );
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
