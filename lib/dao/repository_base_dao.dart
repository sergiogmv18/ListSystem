// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:list_system/models/model_base.dart';

abstract class ReposiroryBaseDao<Model extends ModelBase> {
  @insert
  Future<int> insertLocally(Model object);

  @update
  Future<int> updateLocally(Model object);

  @delete
  Future<int> deleteLocally(Model object);

  Future<int> saveLocally(Model object) async {
    if (object.id != null) {
      //print('updating locally');
      await updateLocally(object);
      return object.id!;
    }
    int id = await insertLocally(object);
    //print('inserting locally');
    return id;
  }
}
