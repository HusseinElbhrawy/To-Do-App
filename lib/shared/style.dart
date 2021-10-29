import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightMode = ThemeData(
  primarySwatch: Colors.deepOrange,
  appBarTheme: const AppBarTheme(
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.deepOrange,
    ),
    color: Colors.white,
    elevation: 0.0,
  ),
  scaffoldBackgroundColor: Colors.white,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
    elevation: 5.0,
    foregroundColor: Colors.deepOrange,
    splashColor: Colors.grey,
  ),
);

ThemeData darkMode = ThemeData(
  //0xff1E2336
  //0xff171D2D
  //0xff26272c
  //0xff292c35
  scaffoldBackgroundColor: const Color(0xff171D2D),
  // primarySwatch: Colors.deepOrange,
  primarySwatch: Colors.red,
  /* tabBarTheme: const TabBarTheme(
    unselectedLabelColor: Colors.grey,
    labelColor: Colors.white,
    indicatorSize: TabBarIndicatorSize.label,
  ),*/
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    backwardsCompatibility: false,
/*    titleTextStyle: TextStyle(
        color: Colors.deepOrange, fontSize: 25, fontWeight: FontWeight.w600),*/
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff171D2D),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Color(0xff171D2D),
    elevation: 0,
  ),
  //primaryColor: Color(0xff1E2336),
  backgroundColor: const Color(0xff1E2336),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 16,
      height: 1.3,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
    elevation: 5.0,
    foregroundColor: Colors.black,
    splashColor: Colors.grey,
  ),
);
