import 'package:flutter/material.dart';
import 'navBar.dart';
import 'kanban.dart';

class Subjects extends StatefulWidget {
  const Subjects({super.key});

  @override
  State<Subjects> createState() => _Subjects();
}

class _Subjects extends State<Subjects> {
  //Subject widget to create new subject
  Widget subject(subjectTitle, subjectNotes) {
    return Column(children: [
      const SizedBox(
        height: 10,
      ),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(200, 100),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: Text("$subjectTitle\n$subjectNotes"),
      )
    ]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Subjects',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Row(
        children: [
          Column(children: [
            subject("Machine Learning",
                "This subject is about machine learning models"),
            subject("Software Engineering",
                "This subject is about how to make software"),
          ]),
          const SizedBox(width: 10),
          Column(
            children: [
              subject("Data science", " "),
              subject("Data compression", " "),
              subject("Data Science", " "),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              subject("Data science", " "),
              subject("Data compression", " "),
              subject("Data Science", " "),
            ],
          ),
        ],
      ),
    );
  }
}
