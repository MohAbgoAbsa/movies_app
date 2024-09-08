import 'package:flutter/material.dart';

class AppTheme {

  /// colors , light theme , dark theme , text theme

  static Color blackColor = const Color(0xff121312);
  static Color redColor = const Color(0xffc7024c);
  static Color cyanColor = const Color(0xff48CFAD);
  static Color greyColor = const Color(0xff282A28);
  static Color greyColor2 = const Color(0xff707070);
  static Color yellowColor = const Color(0xffFFBB3B);
  static Color lightGreyColor = const Color(0xffC6C6C6);
  static Color greyColor3 = const Color(0xff514F4F);
  static Color whiteColor = const Color(0xffffffff);

  static Color bottomNavigationBackgroundColor = const Color(0xff1A1A1A);

  static ThemeData lightTheme = ThemeData(
      cardColor: const Color(0xff343534),
      primaryColor: yellowColor,
      scaffoldBackgroundColor: blackColor,
      appBarTheme: AppBarTheme(
        backgroundColor: greyColor,
        centerTitle: true,
        elevation: 0,
      ),
      textTheme: TextTheme(
          titleLarge: TextStyle(
            color: whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: "Segoe UI",
          ),
          titleMedium: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            fontFamily: "GothamMedium",
          ),
          titleSmall: TextStyle(
            color: whiteColor,
            fontSize: 13,
            fontWeight: FontWeight.normal,
            fontFamily: "GothamMedium",
          )),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: greyColor,
          selectedItemColor: yellowColor,
          unselectedItemColor: lightGreyColor,
          selectedLabelStyle: TextStyle(
            color: whiteColor,
            fontSize: 13,
            fontWeight: FontWeight.normal,
            fontFamily: "GothamMedium",
          ),
          selectedIconTheme: const IconThemeData(
            size: 30,
          ),
          unselectedIconTheme: const IconThemeData(
            size: 25,
          ),
        unselectedLabelStyle: TextStyle(
          color: lightGreyColor,
          fontSize: 13,
          fontWeight: FontWeight.normal,
          fontFamily: "GothamMedium",
        ),

          ));
}
