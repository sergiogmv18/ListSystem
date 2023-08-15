
import 'package:list_system/controllers/task_app_controller.dart';
import 'package:list_system/database/list_system_database.dart';
import 'package:list_system/helpers/service_locator.dart';
import 'package:list_system/models/task.dart';

class SynchronizeController {

 /*
  * Check if there is something that needs to be synced with firebase
  * @author  SGV    - 20230814
  * @version 1.0    - 20230814  - Initial release 
  * @return  <void> 
  */
Future<void> necessarySaveInServer() async{
  List<TaskApp?> allTaskAppToBedeleted = await serviceLocator<ListSystemDatabase>().taskAppDao.allTaskAppToBedeleted();
  List<TaskApp?> allTaskAppToBeEdited = await serviceLocator<ListSystemDatabase>().taskAppDao.allTaskAppToBeEdited();
  if(allTaskAppToBedeleted.isNotEmpty){
    for(var taskAppWk in allTaskAppToBedeleted){
      if(taskAppWk != null){
        await TaskAppController().deleteTaskApp(taskAppWk: taskAppWk);
      } 
    }  
  }
  if(allTaskAppToBeEdited.isNotEmpty){
     for(var taskAppWk in allTaskAppToBeEdited){
      if(taskAppWk != null){
        await TaskAppController().addTaskApp(taskAppWk: taskAppWk);
      } 
    }  
   }
}

}