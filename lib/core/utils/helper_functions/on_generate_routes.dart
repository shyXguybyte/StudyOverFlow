import 'package:flutter/material.dart';
import '../../../view/auth/screen/sig_in_screen.dart';
import '../../../view/splash/screen/splash_screen.dart';


Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const SplashScreen());

    case SignUpScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const SignUpScreen());
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold());
  }
}


// Navigator.pushNamed(context, SignupView.routeName);