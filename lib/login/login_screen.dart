import 'package:ebend/common/alert_action_sheet.dart';
import 'package:ebend/constants/color_constants.dart';
import 'package:ebend/extension/string_extension.dart';
import 'package:ebend/helper/utils.dart';
import 'package:ebend/login/sign_up_screen.dart';
import 'package:ebend/main_screens/home_screen.dart';
import 'package:ebend/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController txtEditEmail = TextEditingController();
  TextEditingController txtEditPassword = TextEditingController();

  bool validations() {
    bool valid = false;
    var strMsg = "";
     if(txtEditEmail.text.isEmpty) {
      strMsg = "Please enter your email";
    } else if(!txtEditEmail.text.isValidEmail()) {
      strMsg = "Please enter valid email";
    } else if(txtEditPassword.text.isEmpty) {
      strMsg = "Please enter password";
    } else if(txtEditPassword.text.length < 6) {
      strMsg = "Please enter atleast 6 characters password";
    } else {
      valid = true;
    }
    if (!valid) {
      AlertActionSheet.showAlert(
          context, "Alert!", strMsg, ["Ok"],
              (index) {
          });
    }
    return valid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Login",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              print("Guest Login");
            },
            child: Text(
              "Guest Login",
              style: TextStyle(color: ColorConstants.mainColor),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: TextFormField(
                    controller: txtEditEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Username",
                      contentPadding: EdgeInsets.all(15),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: TextFormField(
                      controller: txtEditPassword,
                      obscureText: true,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Password",
                        contentPadding: EdgeInsets.all(15),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                      ),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  color: ColorConstants.mainColor,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: TextButton(
                  onPressed: () async {
                    if (validations()) {
                      AuthServices.login(txtEditEmail.text, txtEditPassword.text, context, (success, uid) {
                        if (success) {
                          Utils.push(context, HomeScreen());
                        }
                      });
                    }
                  },
                  child: Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?"),
              TextButton(
                onPressed: () {
                  Utils.push(context, SignUpScreen());
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: ColorConstants.mainColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
