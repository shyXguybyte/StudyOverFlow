import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widget/input_border.dart';
import 'app_color.dart';


ThemeData lightThemeData() => ThemeData(
      scaffoldBackgroundColor: scaffoldBackgroundColor,
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
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        errorStyle: TextStyle(height: 0),
        border: defaultInputBorder,
        enabledBorder: defaultInputBorder,
        focusedBorder: defaultInputBorder,
        errorBorder: defaultInputBorder,
      ),
    );
