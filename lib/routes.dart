import 'package:flutter/material.dart';
import 'package:list_system/screens/splash_screen.dart';


final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/' : (BuildContext context) => const SplashScreen(),
  //'/form/data/finalUser' : (BuildContext context) => FormDataFinalUserScreen( data: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?),  
 
};