

import 'dart:convert';
import 'package:list_system/helpers/function_class.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steel_crypt/steel_crypt.dart';

class CryptoController{


   /*
   * Create a store to sync with firebase when you have internet (encrypted json will be written)
   * @author  SGV    - 20231408
   * @version 1.0    - 20231408  - Initial release 
   * @return  <void> 
   */
  Future<void> writeStorageToSync({required String value}) async {
    final storageToSync = await SharedPreferences.getInstance();
    String payload;
    String? dKey = await FunctionsClass.storage.read(key: 'documentKey');
    Map<String, dynamic>? documentKey = json.decode(dKey!);
    var aes = AesCrypt(key: documentKey!['key'], padding: PaddingAES.none);
    payload = aes.ctr.encrypt(inp: value, iv: documentKey['iv']);
    await storageToSync.setString('storageToSync', payload);
  }


  /*
  * Check if there is something to be synced if yes, sync and remove existing value
  * @author  SGV    - 20231408
  * @version 1.0    - 20231408  - Initial release 
  * @return  <void> 
  */
  Future<Map<String, dynamic>?> readAppDocument() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? storageToSync = sharedPreferences.getString('storageToSync');
    Map<String, dynamic>? response;
    String? decryptedData;
    if(storageToSync != null){
      String? dKey = await FunctionsClass.storage.read(key: 'documentKey');
      Map<String, dynamic>? documentKey =json.decode(dKey!); 
      var aes = AesCrypt(key: documentKey!['key'], padding: PaddingAES.none);
      decryptedData = aes.ctr.decrypt(enc: storageToSync, iv: documentKey['iv']);
      response = json.decode(decryptedData);
    }
    return response;
  }

}