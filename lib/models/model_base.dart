
import 'package:floor/floor.dart';

class ModelBase{

  @PrimaryKey(autoGenerate: true)
  final int ?id;
  bool isNecessarySaveInServer;
  ModelBase({this.id, this.isNecessarySaveInServer = false});

  // GETs
  int? getId(){
    return id;
  }


  bool getIsNecessarySaveInServer(){
    return isNecessarySaveInServer;
  }


  void setIsNecessarySaveInServer(bool isNecessarySaveInServer){
    this.isNecessarySaveInServer = isNecessarySaveInServer;
  }

}