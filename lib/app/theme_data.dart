import 'package:flutter/material.dart';

import 'enums.dart';

final Map<ThemeType, ThemeData> appTheme = {
  ThemeType.Light: lightTheme,
  ThemeType.Dark: darkTheme,
  ThemeType.Black: blackTheme,
};

final Map<int, Color> color = {
  50: Color(0xffbbbdd4),
  100: Color(0xffa3a6c5),
  200: Color(0xff8c91b7),
  300: Color(0xff8186ae),
  400: Color(0xff747ba9),
  500: Color(0xff6a70a0),
  600: Color(0xff5e659b),
  700: Color(0xff464f8a),
  800: Color(0xff30397e),
  900: Color(0xff1a236e),
};

final Map<int, Color> colorDark = {
  50: Colors.black12,
  100: Colors.black26,
  200: Colors.black38,
  300: Colors.black38,
  400: Colors.black45,
  500: Colors.black54,
  600: Colors.black54,
  700: Colors.black87,
  800: Colors.black87,
  900: Colors.black,
};

final ThemeData lightTheme = ThemeData(
  primarySwatch: MaterialColor(0xff1a236e, color),
  primaryColor: Color(0xff0a276a),
  accentColor: Colors.black,
  scaffoldBackgroundColor: Colors.white,
  bottomAppBarColor: Colors.white,
  buttonColor: Color(0xff0a276a),
  dividerColor: Colors.black12,
  cardColor: Colors.white,
  appBarTheme: AppBarTheme(
    color: Colors.white,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xff0a276a),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  ),
  cursorColor: Color(0xff0a276a),
  fontFamily: 'Poppins',
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedItemColor: Colors.white,
    selectedItemColor: Colors.grey[200],
    backgroundColor: Colors.white,
    selectedIconTheme: IconThemeData(
      color: Color(0xff0a276a),
    ),
    unselectedIconTheme: IconThemeData(
      color: Color(0xff777777),
    ),
    selectedLabelStyle: TextStyle(
      color: Color(0xff0a276a),
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelStyle: TextStyle(
      color: Color(0xff777777),
      fontSize: 12,
      fontWeight: FontWeight.bold,
    )
  ),
  textTheme: TextTheme(
    headline5: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    headline6: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      color: Colors.black,
    ),
    subtitle2: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: TextStyle(
      color: Color(0xff555555),
      fontSize: 16,
    ),
    bodyText2: TextStyle(
      color: Color(0xff707070),
    ),
    button: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    overline: TextStyle(
      color: Colors.black,
    ),
    caption: TextStyle(
      color: Color(0xff898989),
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,

  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.all(12),
    errorStyle: TextStyle(color: Color(0xffb00020)),
    labelStyle: TextStyle(
      fontFamily: "Poppins",
      color: Color(0xff565656),
      fontWeight: FontWeight.w300,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(
        color: Colors.black,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(
        color: Colors.black,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(
        color: Color(0xffb00020),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(
        color: Color(0xff003a73),
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(
        color: Color(0xff898989),
      ),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  scaffoldBackgroundColor: Color(0xff121212),
  cursorColor: Colors.blue[200],
  bottomAppBarColor: Color(0xff272727),
  buttonColor: Colors.blue[200],
  unselectedWidgetColor: Colors.grey,
  cardColor: Color(0xff505050),
  dividerColor: Colors.white10,
  appBarTheme: AppBarTheme(
    color: Color(0xff272727),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue[200],
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  ),
  fontFamily: "Poppins",
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Color(0xff272727),
      selectedItemColor: Color(0xff474747),
      backgroundColor: Color(0xff272727),
      selectedIconTheme: IconThemeData(
        color: Colors.blue[200],
      ),
      unselectedIconTheme: IconThemeData(
        color: Color(0xffaaaaaa),
      ),
      selectedLabelStyle: TextStyle(
        color: Colors.blue[200],
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        color: Color(0xff777777),
        fontSize: 12,
        fontWeight: FontWeight.bold,
      )
  ),
  splashColor: Colors.white12,
  highlightColor: Colors.white12,
  textTheme: TextTheme(
    headline5: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    headline6: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    subtitle1: TextStyle(
      color: Color(0xffcacaca),
    ),
    subtitle2: TextStyle(
      color: Color(0xffaaaaaa),
      fontWeight: FontWeight.bold,
    ),
    bodyText1: TextStyle(
      color: Color(0xffaaaaaa),
      fontSize: 16,
    ),
    bodyText2: TextStyle(
      color: Color(0xff808080),
    ),
    button: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    overline: TextStyle(
      color: Colors.white,
    ),
    caption: TextStyle(
      color: Color(0xff898989),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.all(12),
    errorStyle: TextStyle(color: Color(0xffcf6679)),
    labelStyle: TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.w300,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(color: Color(0xffcf6679)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(
        color: Colors.blue[200],
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(
        color: Color(0xff898989),
      ),
    ),
  ),
);

final ThemeData blackTheme = ThemeData(
  primarySwatch: Colors.grey,
  accentColor: Colors.white,
  scaffoldBackgroundColor: Colors.black,
  cursorColor: Colors.blue[200],
  bottomAppBarColor: Colors.black,
  buttonColor: Colors.blue[200],
  unselectedWidgetColor: Colors.grey,
  cardColor: Color(0xff505050),
  dividerColor: Colors.white24,
  appBarTheme: AppBarTheme(
    color: Color(0xff000000),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue[200],
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  ),
  fontFamily: "Poppins",
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  splashColor: Colors.white12,
  highlightColor: Colors.transparent,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.black,
      selectedItemColor: Color(0xff272727),
      backgroundColor: Colors.black,
      selectedIconTheme: IconThemeData(
        color: Colors.blue[200],
      ),
      unselectedIconTheme: IconThemeData(
        color: Color(0xffaaaaaa),
      ),
      selectedLabelStyle: TextStyle(
        color: Colors.blue[200],
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        color: Color(0xff777777),
        fontSize: 12,
        fontWeight: FontWeight.bold,
      )
  ),
  textTheme: TextTheme(
    headline5: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    headline6: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    subtitle1: TextStyle(
      color: Color(0xffcacaca),
    ),
    subtitle2: TextStyle(
      color: Color(0xffaaaaaa),
      fontWeight: FontWeight.bold,
    ),
    bodyText1: TextStyle(
      color: Color(0xffaaaaaa),
      fontSize: 16,
    ),
    bodyText2: TextStyle(
      color: Color(0xff808080),
    ),
    button: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    overline: TextStyle(
      color: Colors.white,
    ),
    caption: TextStyle(
      color: Color(0xff898989),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    errorStyle: TextStyle(color: Color(0xffcf6679)),
    labelStyle: TextStyle(
      fontFamily: "Poppins",
      color: Colors.white70,
      fontWeight: FontWeight.w300,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(color: Color(0xffcf6679)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(
        color: Colors.blue[200],
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(
        color: Color(0xff898989),
      ),
    ),
  ),
);
