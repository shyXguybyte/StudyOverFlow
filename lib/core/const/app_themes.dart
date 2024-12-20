import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_color.dart';


ThemeData lightThemeData() => ThemeData(
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      primaryColor: Colors.amber,
      primarySwatch: primarySwatchColor,
      fontFamily: "Intel",
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: elevatedButtonColor),
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),

    );
