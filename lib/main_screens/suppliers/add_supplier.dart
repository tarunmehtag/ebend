import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebend/common/alert_action_sheet.dart';
import 'package:ebend/constants/color_constants.dart';
import 'package:ebend/extension/string_extension.dart';
import 'package:ebend/helper/utils.dart';
import 'package:ebend/stores/local_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddSupplier extends StatefulWidget {
  const AddSupplier({Key? key}) : super(key: key);

  @override
  _AddSupplierState createState() => _AddSupplierState();
}

class _AddSupplierState extends State<AddSupplier> {

  TextEditingController txtEditSupplierName = TextEditingController();
  TextEditingController txtEditEmail = TextEditingController();
  TextEditingController txtEditPhoneNumber = TextEditingController();
  TextEditingController txtEditContactNumber = TextEditingController();

  bool validations() {
    bool valid = false;
    var strMsg = "";
    if(txtEditSupplierName.text.isEmpty) {
      strMsg = "Please enter Supplier Name";
    } else if(txtEditEmail.text.isEmpty) {
      strMsg = "Please enter email";
    } else if(!txtEditEmail.text.isValidEmail()) {
      strMsg = "Please enter valid email";
    } else if(txtEditPhoneNumber.text.isEmpty) {
      strMsg = "Please enter number";
    } else if(txtEditContactNumber.text.isEmpty) {
      strMsg = "Please select contact number";
    } else {
      valid = true;
    }
    if (!valid) {
      AlertActionSheet.showAlert(context, "Alert!", strMsg, ["Ok"], (index) {});
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
          "Add Supplier",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextFormField(
                controller: txtEditSupplierName,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Supplier Name",
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextFormField(
                controller: txtEditEmail,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Email",
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextFormField(
                controller: txtEditPhoneNumber,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Phone Number",
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextFormField(
                controller: txtEditContactNumber,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Contact Number",
                  contentPadding: EdgeInsets.all(15),
                ),
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
                      addSupplier();
                    }
                  },
                  child: Text(
                    "NEXT",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  addSupplier() async {
    var dict = {
      "supplierName": txtEditSupplierName.text,
      "email": txtEditEmail.text,
      "phoneNumber": txtEditPhoneNumber.text,
      "contactNumber": txtEditContactNumber.text
    };
    CollectionReference users =
    FirebaseFirestore.instance.collection("users");
    var info = await LocalStore.getUserInfo();
    return users.doc(info.uid).collection("supplier").add(dict).then((value) {
      print(value);
      users.doc(info.uid).collection("supplier").doc(value.id).update({"id": value.id}).then((value)  {
        Utils.popBack(context);
      });
    }).catchError((error) {
      AlertActionSheet.showAlert(
          context, "Alert!", error.toString(), ["Ok"], (index) {});
    });
  }
}
