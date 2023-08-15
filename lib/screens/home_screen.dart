
import 'package:flutter/material.dart';
import 'package:list_system/components/app_bar_custom.dart';
import 'package:list_system/components/text_button_custom.dart';
import 'package:list_system/controllers/translate.dart';
import 'package:list_system/helpers/function_class.dart';
import 'package:list_system/helpers/service_locator.dart';
import 'package:list_system/helpers/session.dart';
import 'package:list_system/models/task.dart';
import 'package:list_system/screens/info_taskapp_screen.dart';
import 'package:list_system/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  HomeScreenState createState() =>HomeScreenState();
}
class HomeScreenState extends State<HomeScreen> {
  String? search;
  Session session = serviceLocator<Session>();
  List<TaskApp?> alltask = [];
  @override
  void initState() {
    
    super.initState();
    
  }
  

  
  @override
  Widget build(BuildContext context) {
   alltask = session.getValue('tasks') ?? [];
    return WillPopScope(
      onWillPop: () => FunctionsClass().onWillPop(context),
      child: Scaffold(
        backgroundColor: CustomColors().backgroundColor,
        appBar: appBarCustom(context),
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColors().lightBlue,
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/register/taskApp', (route) => false);
          },
          child: Icon(Icons.add, color: CustomColors().blueLogo),
        ),
        body:Container(
          alignment: Alignment.topCenter,
          padding:const EdgeInsets.fromLTRB(10, 10, 10, 40),
          child:verifyAndShowWidget(alltask),
        ) 
      ),
    );
  }



 /*
  * verify if exist task 
  * @author  SGV
  * @version 1.0 - 20230814 - initial release
  * param <String> tasks - task list 
  * @return<widget>
  */
  verifyAndShowWidget(List<TaskApp?> alltask){
    if(alltask.isNotEmpty){
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            children: [
              Container(
                color: Colors.transparent,
                width:  MediaQuery.of(context).size.width - 40,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 1),
                child: TextFormField(
                   style: Theme.of(context).textTheme.titleSmall,
                  decoration: InputDecoration(
                    contentPadding:const EdgeInsets.only(top: 20), // add padding to adjust text
                    isDense: true,
                    hintText: translate("search"),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                      child: Icon(Icons.search,
                    size:28 ,
                  ),
                ),
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.name,
              initialValue: null,
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
          ),
         showTasksList(search, alltask),
        ],
      );
    });
    }else{
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text(translate('no task'),
             style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ]
        ) 
      );
    }
  }

/*
  * Show list of contact 
  * @author  SGV
  * @version 1.0 - 20230819 - initial release
  * @version 1.2 - 20230819 - Do a search without an accent and placing everything in to lower case
  * param <String> search - filter search 
  * @return<widget>
  */
  showTasksList(String? search,  List<TaskApp?> alltask ){
    List<TaskApp?> taskFilter = [];
    if(search== null || search.isEmpty){
      taskFilter = alltask..sort((a, b) => a!.getTitle()!.toLowerCase().compareTo(b!.getTitle()!.toLowerCase()));
    }else{
      search = FunctionsClass.removeAccents(search).toLowerCase();
      for(var contact in alltask){
        if(FunctionsClass.removeAccents(contact!.getTitle()!).toLowerCase().contains(search)) { 
          taskFilter.add(contact);
        }
      }
    }
    return Expanded(
      child:ListView(
        padding:const EdgeInsets.fromLTRB(10, 20, 10, 0),
        children: [
          for(var task in taskFilter)...[
            textButtonCustom(
              onPressed:()async{
                await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                    backgroundColor: Theme.of(context).primaryColor,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        color: CustomColors().backgroundColor,
                        child: TaskAppInfo(taskApp:task),
                      );
                    }
                  );
                }, 
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.center ,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 13,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor:CustomColors().lightBlue,
                      child: Text(task!.getTitle()![0]),
                    ),
                  ),
                  Container(
                    padding:const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    width:  MediaQuery.of(context).size.width * 0.7,
                    child:Text(task.getTitle()!)
                  ),
                ],
              ), 
            ),
            const SizedBox(height: 20),
          ],  
        ] 
      ) 
    );
  }

}