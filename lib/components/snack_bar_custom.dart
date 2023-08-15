
import 'package:flutter/material.dart';
import 'package:list_system/style.dart';

/*
 * Display message to user at bottom of page
 * @author   SGV        - 20230814
 * @version  1.0        - 20230814  - initial release
 * @param   <string>    - message   - message to be displayed
 * @param   <Color>     - color     - bacground color
 * @param   <int>       - seconds   - how many seconds will the message be displayed
 * @return  <component> - widget
 */
snackBar(BuildContext context, {required  String message,  Color? color, int seconds = 0}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color ??  CustomColors().blueLogo,
      content: Text(message),
      duration:  Duration(seconds: seconds),
    ),
  );
}
