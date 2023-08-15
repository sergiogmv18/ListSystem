import 'package:flutter/material.dart';

/*
 * Component of defined logo
 * @author  SGV       - 20230814
 * @version 1.0       - 20230814 - initial release
 * @param   <double>  - width    - it's not mandatory, defines the width of the image
 * @param   <double>  - height   - it's not mandatory, defines the height of the image
 * @return  <widget> 
 */
definedLogo(BuildContext context, {double? width, double? height}) {
  return Image.asset(
     'assets/logo.png',
      height: height,
      width: width,
  );
}
