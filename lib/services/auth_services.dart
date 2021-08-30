import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebend/common/alert_action_sheet.dart';
import 'package:ebend/helper/utils.dart';
import 'package:ebend/main_screens/home_screen.dart';
import 'package:ebend/models/user_model.dart';
import 'package:ebend/stores/local_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthServices {
  static Future<void> register(String email, String password, BuildContext context, Function(bool, String) completion) async {
    bool success = false;
    var strMsg = "";
    String uid = '';
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      uid = userCredential.user!.uid;
      success = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        strMsg = "The password provided is too weak.";
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        strMsg = "The account already exists for that email.";
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      strMsg = e.toString();
    }
    if(!success) {
      AlertActionSheet.showAlert(
          context, "Alert!", strMsg, ["Ok"],
              (index) {
          });
    } else {
      //Utils.push(context, HomeScreen());
    }
    completion(success, uid);
  }



  static Future<void> login(String email, String password, BuildContext context, Function(bool, String) completion) async {
    bool success = false;
    var strMsg = "";
    var uid = "";
    try {
      UserCredential userCre = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password
      );
      success = true;
      uid = userCre.user!.uid;
      print(userCre.user);
      var document = FirebaseFirestore.instance.collection('users');

      document.doc(uid).get().then((value) {
        print(value.data());
        LocalStore.setUserInfo(UserModel.fromJson(value.data()!));
        completion(success, uid);
      });
      //getUserInfoByUID(uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        strMsg = "No user found for that email.";
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        strMsg = "Wrong password provided for that user.";
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
      strMsg = e.toString();
    }
    print(success);
    if(!success) {
      AlertActionSheet.showAlert(
          context, "Alert!", strMsg, ["Ok"],
              (index) {
          });
      completion(success, uid);
    } else {
      //Utils.push(context, HomeScreen());
    }

  }

  static getUserInfoByUID(String uid) async {
    var document = FirebaseFirestore.instance.collection('users');
    document.doc(uid).get().then((value) {
      print(value.data());
    });
  }
}