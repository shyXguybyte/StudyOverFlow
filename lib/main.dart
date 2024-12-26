import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:study_over_flow/view/splash/screen/splash_screen.dart';

import 'core/const/app_text.dart';
import 'core/const/app_themes.dart';
import 'core/utils/helper_class/shared_pref_hellper.dart';
import 'core/utils/helper_functions/on_generate_routes.dart';

// this is the main function of the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: lightThemeData(),
      home: const SplashScreen(),
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashScreen.routeName,
    );
  }
}
