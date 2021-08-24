import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebend/common/alert_action_sheet.dart';
import 'package:ebend/common/date_picker_pop_up.dart';
import 'package:ebend/constants/color_constants.dart';
import 'package:ebend/extension/string_extension.dart';
import 'package:ebend/helper/utils.dart';
import 'package:ebend/main_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

FirebaseFirestore firestore = FirebaseFirestore.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController txtEditName = TextEditingController();
  TextEditingController txtEditEmail = TextEditingController();
  TextEditingController txtEditDOB = TextEditingController();
  TextEditingController txtEditPassword = TextEditingController();
  TextEditingController txtEditConfirmPassword = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  bool validations() {
    bool valid = false;
    var strMsg = "";
    if(txtEditName.text.isEmpty) {
      strMsg = "Please enter your name";
    } else if(txtEditEmail.text.isEmpty) {
      strMsg = "Please enter your email";
    } else if(!txtEditEmail.text.isValidEmail()) {
      strMsg = "Please enter valid email";
    } else if(txtEditDOB.text.isEmpty) {
      strMsg = "Please select your date of birth";
    } else if(txtEditPassword.text.isEmpty) {
      strMsg = "Please enter password";
    } else if(txtEditPassword.text.length < 6) {
      strMsg = "Please enter atleast 6 characters password";
    } else if(txtEditConfirmPassword.text != txtEditPassword.text) {
      strMsg = "Your password and confirm password does not match";
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
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios , color: Colors.black,),
          onPressed: () {
            Utils.popBack(context);
          },
        ),
        title: Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: TextFormField(
                    controller: txtEditName,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Name",
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
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
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
                      hintText: "Email",
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
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: TextFormField(
                      onTap: () {
                        DatePickerPopUp.showCuperTinoDatePicker(context, "dd-MM-yyyy", DateTime.now(), (formattedDate, utcDate) {
                          txtEditDOB.text = formattedDate;
                        });
                      },
                      controller: txtEditDOB,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Date of Birth",
                        contentPadding: EdgeInsets.all(15),
                        prefixIcon: Icon(
                          Icons.calendar_today_rounded,
                          color: Colors.black,
                        ),
                      ),
                    )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
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
                      controller: txtEditConfirmPassword,
                      obscureText: true,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Confirm Password",
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
                  onPressed: () {
                    if(validations()) {
                      register();
                    }
                    //Utils.push(context, HomeScreen());
                  },
                  child: Text(
                    "SIGN UP",
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
                  Utils.popBack(context);
                },
                child: Text(
                  "Login",
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

  // Example code for registration.
  Future<void> register() async {
    bool success = false;
    var strMsg = "";
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: txtEditEmail.text,
        password: txtEditPassword.text,
      );
      success = true;
      addUser(userCredential.user);
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
      Utils.push(context, HomeScreen());
    }
  }

  Future<void> addUser(User? user) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'name': txtEditName.text,
      'email': txtEditEmail.text, // John Doe
      'dob': txtEditDOB.text,
      'uid': user!.uid
      // Stokes and Sons
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
