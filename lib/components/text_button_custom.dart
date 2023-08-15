
import 'package:flutter/material.dart';

/*
 * Component of button defauld, to be used throughout the app
 * @author  SGV                  - 20230814
 * @version 1.0                  - 20230814   - initial release
 * @param   <Function>           - onPressed  - Function to define action of button  
 * @param   <Widget>             - child       - show child of elevatedButton 
 * @param   <Color>              - customColor - define color 
 * @param  <EdgeInsetsGeometry>  - padding     - padding.zero                                                   
 * @return  <component>  widget TextButton
 */
TextButton textButtonCustom({Key? key, required void Function() onPressed ,EdgeInsetsGeometry? padding = EdgeInsets.zero, Color? backgroundColor, required Widget child}) {
  return TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      backgroundColor: backgroundColor,
      padding:padding,
    ),
    child: child
  ); 
}