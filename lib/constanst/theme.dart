import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  primaryColor: Colors.red,
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: Colors.grey,
      suffixIconColor: Colors.grey,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      errorBorder: outlineInputBorder,
      enabledBorder:outlineInputBorder,
      focusedBorder: outlineInputBorder,
      disabledBorder:outlineInputBorder,
    ),
    appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black)),
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            textStyle: TextStyle(fontSize: 18),
            disabledBackgroundColor: Colors.grey)));


OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey),
);