import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_color.dart';
import 'app_text.dart';


ThemeData lightThemeData() => ThemeData(
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      primaryColor:primaryColor,
      primaryColorDark: primaryColor,
      primaryColorLight: primaryColor,
      primarySwatch: primarySwatchColor,
      fontFamily: intel,
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
