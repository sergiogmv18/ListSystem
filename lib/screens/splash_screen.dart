
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:list_system/components/button_custom.dart';
import 'package:list_system/components/circular_loading.dart';
import 'package:list_system/components/logo_definited.dart';
import 'package:list_system/controllers/synchronize_controller.dart';
import 'package:list_system/helpers/background_fetch.dart';
import 'package:list_system/controllers/task_app_controller.dart';
import 'package:list_system/controllers/translate.dart';
import 'package:list_system/helpers/function_class.dart';
import 'package:list_system/helpers/service_locator.dart';
import 'package:list_system/screens/home_screen.dart';
import 'package:list_system/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  SplashScreenState createState() =>SplashScreenState();
}
class SplashScreenState extends State<SplashScreen> {
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
        body: FutureBuilder<bool>(
          future: initializeDependencies(), // La función asincrónica que devuelve un Future
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Mientras está cargando
              return Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  children: [
                    definedLogo(
                      context,
                      height:  MediaQuery.of(context).size.height * 0.7,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${translate("loading")}...',
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    circularProgressIndicator(context),
                  ]
                )
              );
            } else if (snapshot.hasError || snapshot.data == false) {
               return  Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  children: [
                    definedLogo(
                      context,
                      height:  MediaQuery.of(context).size.height * 0.6,
                    ),
                     Text(
                     translate("something wrong happened. Please restart the app to continue"),
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    buttonCustom(context, customCollor: CustomColors().blueLogo, onPressed: () async {
                      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                    }, child: Text(translate('restart'))),
                  ]
                )
              );
            } else {
              
              return const HomeScreen();
            }
          },
        ),
      ),
    );
  }

 /*
  * initialize dependencies
  * @author  SGV
  * @version 1.0 - 20210506 - initial release
  * @return  <bool> - know what was done successfully
  */
  Future<bool> initializeDependencies() async {
    bool response = false;
    final prefs = await SharedPreferences.getInstance();
   if(prefs.getBool('first_Confirmation') != true && !await FunctionsClass().checkConnectivityApp()){
      return false;
   }
    try {
      await Firebase.initializeApp();
      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      await TranslateController.getInstance().loadTranslations();
      await setupLocator();
      FirebaseFirestore.instance;
      await BackgroundFetchController().initialize();
      if(prefs.getBool('first_Confirmation') == true){
        await startSession();
        await SynchronizeController().necessarySaveInServer();
      }else{
        await TaskAppController().importTasksOfFirebase();

      }
     prefs.setBool('first_Confirmation', true);
      response = true;
    } catch (e) {
      print("Error al inicializar $e");
     return response;
    }


    return response;
  }
}