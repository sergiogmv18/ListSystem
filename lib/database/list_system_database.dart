// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:list_system/dao/task_app_dao.dart';
import 'package:list_system/helpers/date_time_converter.dart';
import 'package:list_system/models/task.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'list_system_database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(
  entities: [
    TaskApp,
  ], 
  version: 1
)
abstract class ListSystemDatabase extends FloorDatabase {
  TaskAppDao get taskAppDao;  

  /*
   * clear all tables
   * @author  SGV
   * @version 1.0 - 20212512 - initial release
   * @return  void
   */
  Future<void> clearAllTables() async {
    await database.execute('DELETE FROM TaskApps');
   
  }



}
