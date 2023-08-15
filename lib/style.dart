import 'package:flutter/material.dart';

/*
 * themes defined for ListSystem, thus defining each color, letter in the entire system
 * @author  SGV - 20230814
 * @version 1.0 - 20230814 - initial release
 */
class ListSystemStyle {
  final ThemeData theme = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: Colors.black,
    primaryColorDark: Colors.black,
    colorScheme: ColorScheme.fromSwatch(errorColor: Colors.red, backgroundColor: Colors.white).copyWith(
      primary: Colors.black,
      secondary:CustomColors().blueShade
    ),
    cardColor: Colors.white,
    canvasColor: Colors.white,
    dividerColor: Colors.black12,
    disabledColor: Colors.grey,
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 20),
      displayMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 36),
      displaySmall: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 24),
      headlineMedium: TextStyle(color: Colors.black38, fontWeight: FontWeight.w300, fontSize: 24),
      headlineSmall: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 20),
      titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 20),
      titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 18),
      titleSmall: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 18),
      bodyLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 15),
      bodyMedium: TextStyle(color: Colors.black45, fontWeight: FontWeight.w300, fontSize: 15),
      bodySmall: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 13),
      labelLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );
}


class CustomColors {
  final Color blueLogo = const Color(0xff3783ff);
  final Color lightBlue =const  Color(0xff9fd6ff);
  final Color blueShade = const Color(0xff2d60b4);
  final Color backgroundColor = Colors.white;
}

class TextThemeCustom {
  static textButtom({Color? color = Colors.black87}) {
    return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1);
  }
}

