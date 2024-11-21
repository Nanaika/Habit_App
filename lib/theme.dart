import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
const defLetterSpacing = -0.75;
const defPaddingH = 16.0;
const defButtonPadding = 16.0;
const defBorderRadius = 32.0;

const blueColor = Color(0xff6EC1FD);

final lightTheme = ThemeData(
  textTheme: const TextTheme(
    displayLarge: TextStyle(letterSpacing: defLetterSpacing, fontWeight: FontWeight.w700, fontSize: 32,),
    displayMedium: TextStyle(letterSpacing: defLetterSpacing, fontWeight: FontWeight.w500, fontSize: 24,),
    displaySmall: TextStyle(letterSpacing: defLetterSpacing, fontSize: 18, fontWeight: FontWeight.w600,),
    bodyLarge: TextStyle(letterSpacing: defLetterSpacing, fontSize: 16, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(letterSpacing: defLetterSpacing, fontSize: 16, fontWeight: FontWeight.w500,),
    bodySmall: TextStyle(letterSpacing: defLetterSpacing, fontSize: 16,),
    labelLarge: TextStyle(letterSpacing: defLetterSpacing, fontSize: 14, fontWeight: FontWeight.w500,),
    labelMedium: TextStyle(letterSpacing: defLetterSpacing, fontSize: 12,),
    labelSmall: TextStyle(letterSpacing: defLetterSpacing, fontSize: 10,),
  ),
  fontFamily: 'sf',
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: Color(0xffF2AA91),
    secondary: Color(0xff29282F),
    onPrimary: Color(0x6629282F),
    surfaceTint: Color(0xffffffff),
    surface: Color(0xffFAF6F0),
    onSurface: Color(0x1429282F),
    // surface: Color(0xffF3F2F7),
    // tertiary: Color(0xff419CFF),
    // secondaryFixed: Color(0xff939393),
    // inverseSurface: Color(0xff1e1e1e),
    // onSurface: Color(0xffffffff),
    // primaryFixed: Color(0xffffffff),
  ),
);

void setLightSystemBars() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color.fromARGB(1, 1, 1, 1),
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark));
}

void setDarkSystemBars() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color.fromARGB(1, 1, 1, 1),
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light));
}

TextTheme getTextTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}
ColorScheme getColor(BuildContext context) {
  return Theme.of(context).colorScheme;
}