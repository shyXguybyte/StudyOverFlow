import 'package:flutter/material.dart';
import 'package:study_over_flow/kanban.dart';
import 'subject.dart';
import 'home_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  final List<Widget> pages = [
    Home(),
    Subjects(),
    Kanban(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.red)
          ),
        ),
      child: NavigationBar(
          labelBehavior: labelBehavior,
          selectedIndex: currentPageIndex,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.amber,
          indicatorColor: Colors.amber,
          indicatorShape: null,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.book_outlined),
              label: 'Subjects',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.view_kanban_sharp),
              icon: Icon(Icons.bookmark_border),
              label: 'Kanban',
            ),
          ])),
      body: <Widget>[
        Card(child: pages[0]),
        Card(
          child: pages[1],
        ),
        Card(
          child: pages[2],
        )
      ][currentPageIndex],
    );
  }
}

// edit
// edit three
