import 'package:flutter/material.dart';
import 'package:myphsar/base_colors.dart';

// The 2018 spec has thirteen text styles:
//
// NAME         SIZE  WEIGHT  SPACING
// headline1    96.0  light   -1.5
// headline2    60.0  light   -0.5
// headline3    48.0  regular  0.0z
// headline4    34.0  regular  0.25
// headline5    24.0  regular  0.0
// headline6    20.0  medium   0.15
// subtitle1    16.0  regular  0.15
// subtitle2    14.0  medium   0.1
// body1        16.0  regular  0.5   (bodyText1)
// body2        14.0  regular  0.25  (bodyText2)
// button       14.0  medium   1.25
// caption      12.0  regular  0.4
// overline     10.0  regular  1.5

ThemeData enBaseTheme = ThemeData(
  fontFamily: 'OpenSans',
  primaryColor: const Color(0xFFCE222C),
  secondaryHeaderColor: const Color(0xFF950004),
  brightness: Brightness.light,
  highlightColor: Colors.white,
  hintColor: const Color(0x80555555),
  textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.deepPurpleAccent, letterSpacing: 0.2),
      displayMedium: TextStyle(color: Colors.green, letterSpacing: 0.2),
      //headline5 Using for title appbar text
      headlineSmall: TextStyle(color: Color(0xFF950004), fontWeight: FontWeight.bold, letterSpacing: 0.2),
      titleLarge: TextStyle(color: Color(0xFF950004), fontWeight: FontWeight.bold, letterSpacing: 0.2),
      bodyLarge: TextStyle(color: ColorResource.secondaryColor),
      // bodyText2 is Default text style for material app
      bodyMedium: TextStyle(color: Color(0xFF555555)),
      titleMedium: TextStyle(
        color: Color(0xFF2B2B2B),
        fontSize: 15,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(color: Color(0xFF555555)),
      labelLarge: TextStyle(color: Color(0xFFFFFFFF), fontSize: 15, letterSpacing: 0.2, fontWeight: FontWeight.w600),
      bodySmall: TextStyle(color: Color(0x80555555), fontSize: 13, letterSpacing: 0.2, fontWeight: FontWeight.w500)),
  colorScheme: const ColorScheme.light().copyWith(primary: const Color(0xFFCE222C)),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);

ThemeData khBaseTheme = ThemeData(
  fontFamily: 'KantumruyPro',
  primaryColor: const Color(0xFFCE222C),
  secondaryHeaderColor: const Color(0xFF950004),
  brightness: Brightness.light,
  highlightColor: Colors.white,
  hintColor: const Color(0x80555555),
  textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.deepPurpleAccent, letterSpacing: 0.2),
      displayMedium: TextStyle(color: Colors.green, letterSpacing: 0.2),
      //headline5 Using for title appbar text
      headlineSmall: TextStyle(color: Color(0xFF950004), fontWeight: FontWeight.bold, letterSpacing: 0.2),
      titleLarge: TextStyle(color: Color(0xFF950004), fontWeight: FontWeight.bold, letterSpacing: 0.2),
      bodyLarge: TextStyle(color: ColorResource.secondaryColor),
      // bodyText2 is Default text style for material app
      bodyMedium: TextStyle(color: Color(0xFF555555)),
      titleMedium: TextStyle(
        color: Color(0xFF2B2B2B),
        fontSize: 15,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(color: Color(0xFF555555)),
      labelLarge: TextStyle(color: Color(0xFFFFFFFF), fontSize: 15, letterSpacing: 0.2, fontWeight: FontWeight.w600),
      bodySmall: TextStyle(color: Color(0x80555555), fontSize: 13, letterSpacing: 0.2, fontWeight: FontWeight.w500)),
  colorScheme: const ColorScheme.light().copyWith(primary: const Color(0xFFCE222C)),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
