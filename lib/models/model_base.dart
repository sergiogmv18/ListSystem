
import 'package:floor/floor.dart';

class ModelBase{

  @PrimaryKey(autoGenerate: true)
  final int ?id;
  bool isNecessarySaveInServer;
  bool deleteInServer;
  ModelBase({this.id, this.isNecessarySaveInServer = false, this.deleteInServer = false});

  // GETs
  int? getId(){
    return id;
  }


  bool getIsNecessarySaveInServer(){
    return isNecessarySaveInServer;
  }

 bool getDeleteServer(){
    return deleteInServer;
  }

 void setDeleteServer(bool deleteInServer){
    this.deleteInServer = deleteInServer;
  }

  void setIsNecessarySaveInServer(bool isNecessarySaveInServer){
    this.isNecessarySaveInServer = isNecessarySaveInServer;
  }

}