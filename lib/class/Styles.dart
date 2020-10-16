import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
        fontFamily: "OpenSans",
        primarySwatch: Colors.red,
        cardTheme: CardTheme(
            color: isDarkTheme ? Color(0xff232931) : Color(0xfffb9d2d2)),
        primaryColor: isDarkTheme ? Color(0xFF303030) : Colors.white,
        backgroundColor: isDarkTheme ? Color(0xFF303030) : Color(0xffF1F5FB),
        indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
        buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
        hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
        highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
        hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
        focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
        disabledColor: Colors.grey,
        textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
        cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
        canvasColor: isDarkTheme ? Color(0xFF060d0c) : Colors.grey[50],
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme:
                isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle:
              TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: isDarkTheme ? Color(0xffffffff) : Color(0xffCBDCF8),
                  width: 1)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: isDarkTheme ? Color(0xffffffff) : Color(0xffCBDCF8),
                  width: 1)),
        ));
  }
}
