import 'package:background_fetch/background_fetch.dart';
import 'package:list_system/controllers/translate.dart';
import 'package:list_system/helpers/function_class.dart';

import '../helpers/service_locator.dart';


class BackgroundFetchController {
 /*
  * Initialize background fetch event
  * @author SGV
  * @version 1.0 - 20220728 - initial release
  * @return  void
  */
  Future<void> initialize() async {
    FunctionsClass.printDebug('################### Configure BackgroundFetch. ################');
    // Configure BackgroundFetch.
    try {
      await BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 15,
          forceAlarmManager: true,
          stopOnTerminate: false,
          startOnBoot: true,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          requiredNetworkType: NetworkType.ANY,
        ),
        _onBackgroundFetch
      );

      /* Check folder and files of agent in background, it is run while the app to be open
      * @version - 1.0 -20220708 -initial release
      * @author  - SGV
      * @return  - background 
      */
      BackgroundFetch.scheduleTask(
        TaskConfig(
          taskId: "com.transistorsoft.verify-status",
          delay: 60000 * 5,
          periodic: true,
          forceAlarmManager: true,
          stopOnTerminate: false,
          enableHeadless: true,
          requiresNetworkConnectivity: false,
          requiresCharging: true,
          requiredNetworkType: NetworkType.ANY
        )
      );
      
      /* Sync with server 24hour
      * @version - 1.0 -20230529 -initial release
      * @author  - SGV
      * @return  - background 
      */
      BackgroundFetch.scheduleTask(
        TaskConfig(
          taskId: "com.transistorsoft.sync-server",
          delay: 3600000 * 24,
          periodic: true,
          forceAlarmManager: true,
          stopOnTerminate: false,
          enableHeadless: true,
          requiresNetworkConnectivity: false,
          requiresCharging: true,
          requiredNetworkType: NetworkType.ANY
        )
      );
    } catch (e) {
      FunctionsClass.printDebug('[BackgroundFetch] configure ERROR: $e');  
    }
  }

  /*
   * Register headless task
   * @author SGV
   * @version 1.0 - 20220728 - initial release
   * @return  void
   */
  void registerHeadlessTask(){
    BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  }

  /*
   * On background fetch
   * @author SGV
   * @version 1.0 - 20220728 - initial release
   * @param   <String> - taskId - name of the specific task to be performed
   * @return  void
   */
  void _onBackgroundFetch(String taskId) async {
      await BackgroundFetchController.executeActionInbackground(taskId);
      BackgroundFetch.finish(taskId);
  }

  /*
  * Execute action in back ground fetch
  * @author SGV
  * @version 1.0      - 20220728 - initial release
  * @param   <String> - taskId   - name of the specific task to be performed
  * @return  void
  */
  static Future<void> executeActionInbackground(String taskId) async {
    await setupLocator();
    await const TranslationDelegate().loadLastApplicationLanguage(); 
  //  if (firstConfirmation != null && firstConfirmation == true) {
      switch(taskId){
        case "com.transistorsoft.sync-server":
          FunctionsClass.printDebug('############# execute background $taskId ##############');
        await startSession();   
        break;
        case "com.transistorsoft.verify-status":
          FunctionsClass.printDebug('############# execute background $taskId ##############');
        ///  await SynchronizeController().checkNewChangeAvailable();
        break;
  //    }
    }
  }
}

/*
* Background fetch headless task
* @author SGV
* @version 1.0 - 20220728 - initial release
* @param   <HeadlessTask> - taskId   - name of the specific task to be performed
* @return  void
*/
void backgroundFetchHeadlessTask(HeadlessTask task) async {
    String taskId = task.taskId;
    await BackgroundFetchController.executeActionInbackground(taskId);
    BackgroundFetch.finish(taskId);
}



