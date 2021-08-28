import 'dart:convert';

import 'package:ebend/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {

  static String userInfoKey = "user_info";

  static setUserInfo(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userInfoKey, json.encode(user.toJson()));
  }

  static Future<UserModel> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var strData = prefs.getString(userInfoKey);
    Map<String, dynamic> dict = json.decode(strData!);
    print(dict);
    return UserModel.fromJson(dict);
  }

}