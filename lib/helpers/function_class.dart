import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:list_system/controllers/translate.dart';
import 'package:intl/intl.dart';

class FunctionsClass {


  /*
   * date parse
   * @author  BSB - 20210330
   * @version 1.0 - 20210330 - initial release
   * @param <String> dateString
   * @return  DateTime
   */
  static DateTime? dateParse(String? dateString) {
    if (dateString == null) {
      return null;
    }

    DateTime? date;

    try {
      date = DateTime.parse(dateString).toLocal();
    } catch (error) {
      date = null;
    }
    return date;
  }


  /*
  * Activate or not be able to go back to the previous page
  * @author  SGVx
  * @version 20230228 - initial release
  * @param   <bool>   - backToScreen -> true  - redirect to specific routeName  
  *                                  -> false -  does not make changes
  * @param   <String> -[routeName]    -> specific route 
  * @param   <Object> - arguments    -> if the screen needs parameters it is sent in the arguments
  * @return  bool;
  */
  Future<bool> onWillPop(BuildContext context, {bool backToScreen = false, Object? arguments, String? routeName}) async {
    if (backToScreen) {
       Navigator.of(context).pushNamedAndRemoveUntil(routeName!, (route) => false, arguments: arguments);
      return backToScreen;
    }
    return backToScreen;
  }

 /*
  * Delete accent in String
  * @author  SGV
  * @version 1.0 - 20230418 - initial release
  * @return  String
  */
  static String removeAccents(String str) {
    var withDia = 'ŠŒŽšœžŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøüùúûýýþÿŔŕƒ';
    var withoutDia = 'SOZsozYYuaaaaaaaceeeeiiiidnoooooouuuuybsaaaaaaaceeeeiiiidnoooooouuuuyybyRra';
    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }
    return str;
  }


  /*
  * Country-specific closing format
  * @author SGV
  * @version 20230227 initial release
  * @return  String;
  */
  static countrySpecificClosingFormat() {
    String locale = TranslateController.localeTag;
    String? format;
    switch (locale) {
      case 'pt_BR':
        format = 'dd/MM/yyyy';
        break;
       case 'en':
          format = 'yyyy-MM-dd';
        break;
      default:
         format = 'dd.MM.yyyy';
        break;
    }
    return format;
  }


  /*
  * Show data in debug console
  * @author SGV
  * @version 20230215 initial release
  * @param <var> debug - object to see
  * @return  void
  */
  static printDebug(var debug) {
    log(debug.toString());
  }


  /*
  * Border randius standard
  * @author SGV
  * @version 20230223 initial release
  * @return  BorderRadiusGeometry
  */
  static borderRadiusfixed({double radius = 4}) {
    BorderRadiusGeometry? borderRadius = BorderRadius.all(Radius.circular(radius));
    return borderRadius;
  }


  /*
  * initial global flutter secure storange
  * @author SGV
  * @version 20230215 initial release
  * @return  void
  */
  static FlutterSecureStorage storage = const FlutterSecureStorage();



  /*
   * trim left
   * @author  SGV
   * @version 1.0    - 20230215 - Initial release 
   * @param <String> - string - value in string to verify
   * @param <String> -  characters - quantity charac
   * @return <String>
   */
  static String trimLeft(String string, String characters) {
    string = string.trim();
    characters = characters.trim();
    if (characters.length > string.length) {
      return string;
    }
    if (string.isEmpty || characters.isEmpty) {
      return string;
    }
    String value = string.substring(0, characters.length).trim();
    if (value == characters) {
      return string.substring(characters.length);
    }
    return string;
  }

  /*
  * Format date
  * @author  SGV - 20230215
  * @version 1.0 - 20230215 - initial release
  * @param <DateTime> date
  * @param <String> format
  * @return  String
  */
  static String? formatDate(DateTime? date, {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    if (date == null) {
      return null;
    }
    String? dateString;
    try {
      DateFormat dateFormat = DateFormat(format);
      dateString = dateFormat.format(date);
    } catch (error) {
      dateString = null;
    }
    return dateString;
  }
}
