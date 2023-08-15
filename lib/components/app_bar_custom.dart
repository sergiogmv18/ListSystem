import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:list_system/components/logo_definited.dart';
import 'package:list_system/components/text_button_custom.dart';
import 'package:list_system/style.dart';


/*
 * Component of appBar defauld, to be used throughout the app
 * @author  SGV            - 20230814
 * @version 1.0            - 20230814         - initial release
 * @param   <BuildContext> - context          - current context  
 * @param   <bool>         - showButtonReturn - know if it is necessary to show the button to return
 * @param   <String>       - route            - specific route 
 * @param   <Object>       - arguments        - argument expected by the screen
 * @return <component> widget AppBar
 */
appBarCustom(BuildContext context, {bool showButtonReturn = false, String? route, Object? arguments}) {
  return AppBar(
    automaticallyImplyLeading: showButtonReturn,
    leading:showButtonReturn ? Container( 
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0), 
      child: textButtonCustom(
        onPressed: (){
          Navigator.of(context).pushNamedAndRemoveUntil(route!, (route) => false, arguments: arguments);
        },
        child: FaIcon(FontAwesomeIcons.arrowLeft, size: 40, color: CustomColors().backgroundColor)
      ) 
    ): null,
    elevation: 2,
    toolbarHeight: 100,
    backgroundColor: CustomColors().blueLogo,
    title:definedLogo(context, width: 250),
    centerTitle: true,
  );
}

