
import 'package:floor/floor.dart';
import 'package:list_system/models/task.dart';
import 'repository_base_dao.dart';

@dao
abstract class TaskAppDao extends ReposiroryBaseDao<TaskApp> {
  @Query('SELECT * FROM TaskApps')
  Future<List<TaskApp>> fetchAll();

  @Query('SELECT * FROM TaskApps WHERE id = :id')
  Future<TaskApp?> fetchById(int id);

  @Query('DELETE FROM TaskApps')
  Future<void> deleteAll();
}
