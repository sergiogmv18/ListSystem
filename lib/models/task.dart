import 'package:floor/floor.dart';
import 'package:list_system/helpers/function_class.dart';
import 'model_base.dart';
/// A TaskApp used in the app's 
/// 
/// Should not be mistaken with Event class from task of flutter module
@Entity(tableName: 'TaskApps')
class TaskApp extends ModelBase{
  String? title;
  String? creationDate;
  String? updateDate;
  String? description;
  TaskApp({int? id, bool isNecessarySaveInServer = false, this.title, this.creationDate, this.updateDate, this.description}): super(id: id, isNecessarySaveInServer:isNecessarySaveInServer);
  // GET
  String? getTitle() {
    return title;
  }
  DateTime? getStart() {
    return FunctionsClass.dateParse(creationDate);
  }
  DateTime? getEnd() {
    return FunctionsClass.dateParse(updateDate);
  }
  String? getDescription() {
    return description;
  }

// SET 
  void setTitle(String? title){
    this.title = title;
  }
  void setStart(DateTime? creationDate){
    this.creationDate = FunctionsClass.formatDate(creationDate);
  }
  void setUpdateDate(DateTime? updateDate){
    this.updateDate = FunctionsClass.formatDate(updateDate);
  }
  void setDescription(String? description){
    this.description = description;
  }
  


  /// other methods
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isNecessarySaveInServer': isNecessarySaveInServer,
      'creationDate': creationDate,
      'title':title,
      'updateDate':updateDate,
      'description': description,
    };
  }

}



