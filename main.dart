import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'navBar.dart';
void main() async{

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const NavBar(),
    );
  }
}