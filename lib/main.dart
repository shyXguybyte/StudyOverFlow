import 'package:flutter/material.dart';
import 'package:study_over_flow/view/splash/screen/splash_screen.dart';

import 'core/const/app_text.dart';
import 'core/const/app_themes.dart';
import 'core/utils/helper_functions/on_generate_routes.dart';

// this is the main function of the app
void main() {
  runApp(const MyApp());
}


// This widget is the root of your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: lightThemeData(),
      home: const SplashScreen(),
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashScreen.routeName,
    );
  }
}

