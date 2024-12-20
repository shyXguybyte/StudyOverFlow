import 'package:flutter/material.dart';
import '../../../view/auth/screen/confirm_screen.dart';
import '../../../view/auth/screen/forget_password.dart';
import '../../../view/auth/screen/login_screen.dart';
import '../../../view/auth/screen/rest_password_screen.dart';
import '../../../view/auth/screen/sig_in_screen.dart';
import '../../../view/onBoarding/screen/onboarding_screen.dart';
import '../../../view/splash/screen/splash_screen.dart';


Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const SplashScreen());

    case SigInScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const SigInScreen());
    case ConfirmEmailScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const ConfirmEmailScreen());
    case RestPasswordScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const RestPasswordScreen());  
    case LogInScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const LogInScreen());
    case ForgetPasswordScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen());  
    case OnboardingScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const OnboardingScreen());  
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold());
  }
}


// Navigator.pushNamed(context, SignupView.routeName);