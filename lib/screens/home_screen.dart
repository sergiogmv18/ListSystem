
import 'package:flutter/material.dart';
import 'package:list_system/components/app_bar_custom.dart';
import 'package:list_system/helpers/function_class.dart';
import 'package:list_system/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  HomeScreenState createState() =>HomeScreenState();
}
class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }
  

  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => FunctionsClass().onWillPop(context),
      child: Scaffold(
        backgroundColor: CustomColors().backgroundColor,
        appBar: appBarCustom(context),
        body: Container(


        ),
      ),
    );
  }

}