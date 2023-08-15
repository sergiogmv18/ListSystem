
import 'package:flutter/material.dart';
import 'package:list_system/components/app_bar_custom.dart';
import 'package:list_system/components/button_custom.dart';
import 'package:list_system/components/circular_loading.dart';
import 'package:list_system/components/info_success.dart';
import 'package:list_system/components/text_form_field_component.dart';
import 'package:list_system/controllers/task_app_controller.dart';
import 'package:list_system/controllers/translate.dart';
import 'package:list_system/helpers/function_class.dart';
import 'package:list_system/models/task.dart';
import 'package:list_system/style.dart';

class RegisterOrEditTaskAppScreen extends StatefulWidget {
  final TaskApp? taskApp;
  const RegisterOrEditTaskAppScreen({super.key, this.taskApp});
  @override
  RegisterOrEditTaskAppScreenState createState() =>RegisterOrEditTaskAppScreenState();
}
class RegisterOrEditTaskAppScreenState extends State<RegisterOrEditTaskAppScreen> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  bool edit = false;
  TaskApp taskAppWk = TaskApp();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     if(widget.taskApp != null){
      taskAppWk = widget.taskApp!;
      controllerTitle = TextEditingController(text: taskAppWk.getTitle()!);
      controllerDescription =TextEditingController(text: taskAppWk.getDescription()!);
      edit = true;
    }
    return WillPopScope(
      onWillPop: () => FunctionsClass().onWillPop(context),
      child: Scaffold(
        backgroundColor: CustomColors().backgroundColor,
        appBar: appBarCustom(
          context,
          showButtonReturn: true,
          route: '/home'
        ),
        body:ListView(
          padding:const EdgeInsets.fromLTRB(10, 10, 10, 40),
          children: [
            Form(
              key:formKey,
              child: Column(
                children: [
                  TextFormFieldCustom(
                    controller: controllerTitle,
                    keyboardType: TextInputType.name,
                    textInputAction:  TextInputAction.done,
                    labelText: translate('title'),
                    maxLines: 1,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return translate('please insert a valid value');
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (value.trim().isEmpty) {
                        controllerTitle.clear();
                      } else {
                        controllerTitle.value.copyWith(text: value);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
// DESCRIPTION
                  TextFormFieldCustom(
                    controller: controllerDescription,
                    keyboardType: TextInputType.name,
                    textInputAction:  TextInputAction.newline,
                    labelText: translate('description'),
                    maxLines: 4,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return translate('please insert a valid value');
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (value.trim().isEmpty) {
                        controllerDescription.clear();
                      } else {
                        controllerDescription.value.copyWith(text: value);
                      }
                    },
                  )
                ],
              )
            ),
  // BUTTOM SAVE 
            const SizedBox(height: 30),
            buttonCustom( 
              context, 
              width: MediaQuery.of(context).size.width - 20, 
              onPressed: () async {
              if (formKey.currentState!.validate()) {
                showCircularLoadingDialog(context);
                  taskAppWk.setDescription(controllerDescription.text);
                  taskAppWk.setTitle(controllerTitle.text);
                  if(!edit){
                    taskAppWk.setCreationDate(FunctionsClass.dateParse(FunctionsClass.formatDate(DateTime.now())));
                    taskAppWk.setUpdateDate(null);
                  }else{
                    taskAppWk.setUpdateDate(FunctionsClass.dateParse(FunctionsClass.formatDate(DateTime.now())));
                  }
                  await TaskAppController().addTaskApp(taskAppWk: taskAppWk, edit:edit);
                  showMessageForUser(context, '/home'); 
                  
                }
              },
              customCollor: CustomColors().blueLogo,
              child:Text(
                translate("save"),
                textAlign: TextAlign.center,
              ), 
            ),           
          ],
        )        
      ),
    );
  }
}