

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:list_system/helpers/function_class.dart';
import 'package:list_system/models/task.dart';

class TaskAppController  extends ChangeNotifier { 
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<TaskApp> _tasks = [];
  List<TaskApp> get tasks => _tasks;

 /*
   * Add task or edit
   * @author  SGV    - 20231408
   * @version 1.0    - 20231408  - Initial release 
   * param    <OBJ>  - task to create or update
   * @return  <void> -
   */
  Future<void> addTaskApp({required TaskApp taskApp}) async {



    _tasks.add(taskApp);
    notifyListeners();
  }

 /*
  * delete specific task
  * @author  SGV    - 20231408
  * @version 1.0    - 20231408  - Initial release 
  * @return  <void> 
  */
  Future<void> deleteTaskApp() async {

  }
  



  

 /*
  * Get all tasks
  * @author  SGV    - 20231408
  * @version 1.0    - 20231408  - Initial release 
  * @return  <void> 
  */
  Future<List<TaskApp?>> getAllTask() async {
    FunctionsClass.printDebug(  firestore.collection("TaskApps").snapshots());
    firestore.collection("TaskApps");
    List<TaskApp?> task = [];

    return task;
  }

}