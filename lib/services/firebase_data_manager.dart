import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebend/common/alert_action_sheet.dart';
import 'package:ebend/models/user_model.dart';
import 'package:ebend/stores/local_store.dart';
import 'package:flutter/cupertino.dart';

class FirebaseDataManager {
  static Future<void> addUser(String collectName, Map<String, dynamic> dict,
      BuildContext context, Function(bool) completion) {
    CollectionReference users =
        FirebaseFirestore.instance.collection(collectName);
    return users.add(dict).then((value) {
      print(value.id);
      users
          .doc(value.id)
          .update({"id": value.id}).then((_) {
        print("success!");
        var newDict = dict;
        newDict["id"] = value.id;
        LocalStore.setUserInfo(UserModel.fromJson(newDict));
        completion(true);
      });
    }).catchError((error) {
      AlertActionSheet.showAlert(
          context, "Alert!", error.toString(), ["Ok"], (index) {});
      completion(false);
    });
  }


}
