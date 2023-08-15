

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:list_system/database/list_system_database.dart';
import 'package:list_system/helpers/function_class.dart';
import 'package:list_system/helpers/service_locator.dart';
import 'package:list_system/models/task.dart';

class TaskAppController{ 
  FirebaseFirestore firestore = FirebaseFirestore.instance;

 /*
   * Add task or edit
   * @author  SGV    - 20230814
   * @version 1.0    - 20230814  - Initial release 
   * param    <OBJ>  - task to create or update
   * @return  <void> -
   */
  Future<void> addTaskApp({required TaskApp taskAppWk, bool edit = false}) async {
    bool connectivity = await FunctionsClass().checkConnectivityApp();
    if(connectivity){
      taskAppWk.setIsNecessarySaveInServer(false);
      try {
        if(!edit){
          await firestore.collection('TaskApps').doc(taskAppWk.getIdFirebase()).update(
            {
              'description':taskAppWk.getDescription(),
              'creationDate':FunctionsClass.formatDate(taskAppWk.getCreationDate()) ,
              'updateDate':FunctionsClass.formatDate(taskAppWk.getUpdateDate()),
              'title': taskAppWk.getTitle(),
            }
          );
        }else{
          await firestore.collection('TaskApps').add(
            {
              'description':taskAppWk.getDescription(),
              'creationDate':FunctionsClass.formatDate(taskAppWk.getCreationDate()),
              'updateDate':null,
              'title': taskAppWk.getTitle(),
            }
          );
        }
      } catch (e) {
        if (e is SocketException) {
        FunctionsClass.printDebug(e.port);
        } else if (e is TimeoutException) {
        FunctionsClass.printDebug(e);
        } else {
          FunctionsClass.printDebug(e);
        }
    
        FunctionsClass.printDebug(e);
        taskAppWk.setIsNecessarySaveInServer(true);
      }
      await serviceLocator<ListSystemDatabase>().taskAppDao.saveLocally(taskAppWk);
      await startSession();
   }else{
      taskAppWk.setIsNecessarySaveInServer(true);
      await serviceLocator<ListSystemDatabase>().taskAppDao.saveLocally(taskAppWk);
      await startSession();
   }
    
  }

 /*
  * delete specific task
  * @author  SGV    - 20230814
  * @version 1.0    - 20230814  - Initial release 
  * @return  <void> 
  */
  Future<void> deleteTaskApp({required TaskApp taskAppWk}) async {
    bool connectivity = await FunctionsClass().checkConnectivityApp();
    if(connectivity){
      try {
        await firestore.collection('TaskApps').doc(taskAppWk.getIdFirebase()).delete();
        await serviceLocator<ListSystemDatabase>().taskAppDao.deleteLocally(taskAppWk);
      } catch (e) {
        FunctionsClass.printDebug(e);
        taskAppWk.setDeleteServer(true);
        await serviceLocator<ListSystemDatabase>().taskAppDao.saveLocally(taskAppWk);
      }
    }else{
      taskAppWk.setDeleteServer(true);
      await serviceLocator<ListSystemDatabase>().taskAppDao.saveLocally(taskAppWk);
    }
    await startSession();
  }
  



  

 /*
  * Get all tasks
  * @author  SGV    - 20230814
  * @version 1.0    - 20230814  - Initial release 
  * @return  <void> 
  */
  Future<List<TaskApp?>> getAllTask() async {
    List<TaskApp?> tasksApp = await serviceLocator<ListSystemDatabase>().taskAppDao.fetchAll();
    return tasksApp;
  }


  /*
  * Check if the firebase database has values and pick up the local dice database
  * @author  SGV    - 20230814
  * @version 1.0    - 20230814  - Initial release 
  * @return  <void> 
  */
  importTasksOfFirebase()async{
    final collection = FirebaseFirestore.instance.collection('TaskApps');
    final snapshot = await collection.get();
    for (final doc in snapshot.docs) {
    final taskData = doc.data();
    TaskApp taskAppWk = TaskApp();
    taskAppWk.setIdFirebase(doc.id);
    taskAppWk.setDescription(taskData['description']);
    taskAppWk.setTitle(taskData['title']);
    taskAppWk.setCreationDate(FunctionsClass.dateParse(taskData['creationDate']));
    taskAppWk.setUpdateDate(FunctionsClass.dateParse(taskData['updateDate']));
    await serviceLocator<ListSystemDatabase>().taskAppDao.saveLocally(taskAppWk);
    }
    await startSession();
  }

}