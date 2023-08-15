import 'package:flutter/material.dart';
import 'package:list_system/components/circular_loading.dart';
import 'package:list_system/components/info_success.dart';
import 'package:list_system/controllers/task_app_controller.dart';
import 'package:list_system/controllers/translate.dart';
import 'package:list_system/helpers/function_class.dart';
import 'package:list_system/models/task.dart';
import 'package:list_system/style.dart';


class TaskAppInfo extends StatelessWidget {
  final TaskApp taskApp;
  const TaskAppInfo({super.key, required this.taskApp});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding:const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child:  RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:taskApp.getTitle()!,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold, color: CustomColors().colorDark),                                
                  ),
                  const TextSpan(text:'\n\n'),
                  TextSpan(
                      text:'${translate('description')}: ',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),                                  
                    ),
                   TextSpan(
                      text:taskApp.getDescription()!,
                      style: Theme.of(context).textTheme.titleSmall!                                  
                    ),
                  const TextSpan(text:'\n'),
                  TextSpan(
                      text:'${translate('creation date')}: ',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),                                  
                    ),
                   TextSpan(
                      text:FunctionsClass.formatDate(taskApp.getCreationDate(), format: FunctionsClass.countrySpecificClosingFormat()),
                      style: Theme.of(context).textTheme.titleSmall!                                  
                    ),
                  const TextSpan(text:'\n'),
                  TextSpan(
                      text:'${translate('update date')}: ',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),                                  
                    ),
                   TextSpan(
                      text: taskApp.getUpdateDate() != null ? FunctionsClass.formatDate(taskApp.getUpdateDate(), format: FunctionsClass.countrySpecificClosingFormat()) :translate('it has not been modified since its creation'),
                      style: Theme.of(context).textTheme.titleSmall!                                  
                    ),
                  const TextSpan(text:'\n'),
                ] 
              ),
            ),
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor:CustomColors().colorOxi),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: FunctionsClass.borderRadiusfixed()),
                      insetPadding: EdgeInsets.all(20),
                      child:Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child:Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding:const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child:Text(
                                translate('attention'),
                                style : Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 18,
                              ),
                            ),
                            Text(
                              '${translate('do you want to delete the task')}?',
                              style : Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 18,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(foregroundColor:CustomColors().colorOxi),
                                  onPressed: () async {
                                      Navigator.of(context).pop();
                                  },
                                  child: Text(translate('cancel')),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(foregroundColor:CustomColors().blueLogo),
                                  onPressed: () async {
                                    showCircularLoadingDialog(context);
                                    await TaskAppController().deleteTaskApp(taskAppWk: taskApp);
                                    showMessageForUser(context, '/home'); 
                                  },
                                  child: Text(translate('delete')),
                                ),
                              ]
                            )
                          ]
                        ) 
                      )
                    );
                  }
                );
              },
              child: Text(translate('delete')),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor:CustomColors().blueLogo),
              onPressed: () async {
                  Navigator.of(context).pushNamedAndRemoveUntil('/register/taskApp', (route) => false, arguments: taskApp);
              },
              child: Text(translate('edit')),
            ),
          ],
        ),
      ]
    );
  }

}
