import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../screen/calender.dart';
import '../screen/kanban.dart';
import '../screen/notes.dart';
import '../screen/settings.dart';
import '../screen/subject.dart';


class NavBar extends StatelessWidget {
  const NavBar({super.key});
  static const routeName = "/home_screen";

  @override
  Widget build(BuildContext context) {
    // PersistentTabController to manage the active tab
    final PersistentTabController controller =
        PersistentTabController(initialIndex: 0);


    // List of navigation items
    final List<PersistentBottomNavBarItem> navBarsItems = [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.calendar_today),
        title: ("Calendar"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.note),
        title: ("Notes"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.dashboard),
        title: ("Kanban"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.subject),
        title: ("Subjects"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];

List<Widget> buildScreens() {
    return [
       MyHomePage(),
      Notes(),
      Kanban(),
      Subjects(),
      Settings(),
    ];
  }
    // Build the PersistentTabView
     return PersistentTabView(
      context,
      controller: controller,
      screens: buildScreens(),
      items: navBarsItems,
      confineToSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarStyle: NavBarStyle.style3, // Choose your desired style
    );
  }
}
