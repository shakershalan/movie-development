import 'package:flutter/material.dart';

class MyTheme {
  static Color whiteColor = Color(0xffFFFFFF);
  static Color backgroundColor = Color(0xff121312);
  static Color yellowColor = Color(0xffFFBB3B);
  static Color greyColor = Color(0xff938E8E);
  static Color bottomColor = Color(0xff1A1A1A);
  static Color darkGreyColor = Color(0xff514F4F);
  static Color containerFilmColor = Color(0xff282A28);

  static ThemeData LightTheme = ThemeData(
    textTheme: TextTheme(
        titleSmall: TextStyle(fontSize: 8, fontWeight: FontWeight.bold,color: greyColor),
        titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w200,color: whiteColor),
        titleLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: whiteColor)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
        selectedItemColor: MyTheme.yellowColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: MyTheme.greyColor),
    scaffoldBackgroundColor: backgroundColor,
  );
}
