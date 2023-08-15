import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:list_system/controllers/task_app_controller.dart';
import 'package:list_system/routes.dart';
import 'package:list_system/style.dart';
import 'package:provider/provider.dart';
import 'controllers/translate.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TranslateController.getInstance()),
        ChangeNotifierProvider(create: (context) => TaskAppController()),
      ],
      child: const ListSystem(),
    )
  );
}
class ListSystem extends StatelessWidget {
  const ListSystem({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List System',
      theme: ListSystemStyle().theme,
      localizationsDelegates: const [
        TranslationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routes: routes,
      supportedLocales: TranslateController.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
