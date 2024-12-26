import 'package:flutter/material.dart';
import 'package:home_function/constants/Colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AddAppointmentDialog extends StatefulWidget {
  @override
  State<AddAppointmentDialog> createState() => _AddAppointmentDialogState();
}

class _AddAppointmentDialogState extends State<AddAppointmentDialog> {
  final _titleController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay(hour: 8, minute: 0);
  final _durationController = TextEditingController();
  DateTime _selectedDay = DateTime.now();
  Color _selectedColor = electricBlue;
  final _descriptionController = TextEditingController();

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

            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(hintText: "Description"),
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
            //Time Picker
            TextButton(
              onPressed: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: child!,
                    );
                  },
                  errorInvalidText: "Invalid Time",
                );
                if (selectedTime != null &&
                    (selectedTime.hour >= 8 && selectedTime.hour <= 23)) {
                  // Valid time, proceed with the logic
                  setState(() {
                    _selectedTime = selectedTime;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Please select a time between 8:00 AM and 11:59 PM."),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              child: Text("⏰ Select Time: ${_selectedTime.format(context)}"),
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

            if (duration < 0) {
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
              _selectedTime.hour,
              _selectedTime.minute,
            );


            final endTime = startTime.add(Duration(hours: duration));

            final appointment = Appointment(
              startTime: startTime,
              endTime: endTime,
              subject: title,
              color: _selectedColor,
              notes: _descriptionController.text,
            );

            Navigator.pop(context, appointment);
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}
