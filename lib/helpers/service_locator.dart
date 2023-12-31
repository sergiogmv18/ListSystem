import 'package:get_it/get_it.dart';
import 'package:list_system/controllers/task_app_controller.dart';
import 'package:list_system/database/list_system_database.dart';
import 'package:list_system/helpers/session.dart';
import 'package:list_system/models/task.dart';

GetIt serviceLocator = GetIt.instance;

/*
  * Register global instance of session and database
  * @author  SGV
  * @version 1.0 - 20230814 - initial release
  * @return  void
  */
Future<void> setupLocator() async {
  if (!serviceLocator.isRegistered<ListSystemDatabase>()) {
    ListSystemDatabase databaseInstance = await $FloorListSystemDatabase.databaseBuilder('listsystem_database.db').build();
    serviceLocator.registerSingleton<ListSystemDatabase>(databaseInstance);
  }
  if (!serviceLocator.isRegistered<Session>()) {
    Session session = Session();
    serviceLocator.registerSingleton<Session>(session);
  }
}

/*
  * Set data session
  * @author  SGV
  * @version 1.0 - 20230814 - initial release
  * @return  void
  */
Future startSession() async {
  Session session = serviceLocator<Session>();
  List<TaskApp?> alltask = await TaskAppController().getAllTask();
  session.setValue('tasks', alltask);
}
