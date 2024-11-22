import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const defLetterSpacing = -0.75;
const defPaddingH = 16.0;
const defButtonPadding = 16.0;
const defBorderRadius = 32.0;

const blue = Color(0xff6EC1FD);
const red = Color(0xffFD886E);
const violet = Color(0xffCEB5F2);
const green = Color(0xffA2E492);

final lightTheme = ThemeData(
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      letterSpacing: defLetterSpacing,
      fontWeight: FontWeight.w700,
      fontSize: 32,
    ),
    displayMedium: TextStyle(
      letterSpacing: defLetterSpacing,
      fontWeight: FontWeight.w500,
      fontSize: 24,
    ),
    displaySmall: TextStyle(
      letterSpacing: defLetterSpacing,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(letterSpacing: defLetterSpacing, fontSize: 16, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(
      letterSpacing: defLetterSpacing,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      letterSpacing: defLetterSpacing,
      fontSize: 16,
    ),
    labelLarge: TextStyle(
      letterSpacing: defLetterSpacing,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      letterSpacing: defLetterSpacing,
      fontSize: 12,
    ),
    labelSmall: TextStyle(
      letterSpacing: defLetterSpacing,
      fontSize: 10,
    ),
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

const String privacyPolicy =
    ''' The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
  Here is where you can list and ban behaviors and activities like:
    \u25CF Obscene, crude, or violent posts
    \u25CF False or misleading content
    \u25CF Breaking the law
    \u25CF Spamming or scamming the service or other users
    \u25CF Hacking or tampering with your website or app
    \u25CF Violating copyright laws
    \u25CF Harassing other users
    \u25CF Stalking other users
  If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.''';
const String termOfUse =
    ''' The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
  Here is where you can list and ban behaviors and activities like:
    \u25CF Obscene, crude, or violent posts
    \u25CF False or misleading content
    \u25CF Breaking the law
    \u25CF Spamming or scamming the service or other users
    \u25CF Hacking or tampering with your website or app
    \u25CF Violating copyright laws
    \u25CF Harassing other users
    \u25CF Stalking other users
  If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.''';
