import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFff5a5f);
const Color secondaryColor = Color(0xFF00a699);
const Color backgroundColor = Color(0xFFF7F7F7);
const Color greyColor = Color(0xFF767676);
const Color darkgrey = Color(0xFF484848);


const TextStyle headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

// final TextStyle montserratBodyTextStyle = GoogleFonts.montserrat(
//   fontSize: 18,
//   color: Colors.black,
// );

const TextStyle bodyTextStyle = TextStyle(
  
  fontSize: 18,
  color: Colors.black,
);

// ignore: prefer_const_declarations
final ColorScheme myColorScheme = const ColorScheme(
  primary: primaryColor,
  secondary: secondaryColor,
  surface: backgroundColor,
  error: Colors.red,
  onPrimary: backgroundColor,
  onSecondary: Colors.black,
  onSurface: Colors.black,
  onError: Colors.white,
  brightness: Brightness.light,
);


final TextTheme myTextTheme = TextTheme(
  displayLarge: headingStyle.copyWith(fontSize: 32),
  displayMedium: headingStyle.copyWith(fontSize: 28),
  displaySmall: headingStyle.copyWith(fontSize: 21),
  bodyLarge: bodyTextStyle,
  bodyMedium: bodyTextStyle.copyWith(color: greyColor),
  labelLarge: bodyTextStyle.copyWith(fontWeight: FontWeight.bold),
);

final ThemeData myTheme = ThemeData(
  colorScheme: myColorScheme,
  textTheme: myTextTheme,
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: backgroundColor,
    titleTextStyle: headingStyle,
  ),
  
  buttonTheme: const ButtonThemeData(
    buttonColor: primaryColor,
    textTheme: ButtonTextTheme.primary,
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: greyColor), 
    ),
    labelStyle: bodyTextStyle,
    hintStyle: bodyTextStyle.copyWith(color: darkgrey),
  ),
  scaffoldBackgroundColor: backgroundColor,
);
