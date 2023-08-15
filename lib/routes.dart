import 'package:flutter/material.dart';
import 'package:list_system/models/task.dart';
import 'package:list_system/screens/home_screen.dart';
import 'package:list_system/screens/register_or_edit_taskapp_screen.dart';
import 'package:list_system/screens/splash_screen.dart';


final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/' : (BuildContext context) => const SplashScreen(),
  '/home' : (BuildContext context) => const HomeScreen(),
  '/register/taskApp': (BuildContext context) => RegisterOrEditTaskAppScreen(taskApp: ModalRoute.of(context)!.settings.arguments as TaskApp?), 
  //'/form/data/finalUser' : (BuildContext context) => FormDataFinalUserScreen( data: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?),  
 
};