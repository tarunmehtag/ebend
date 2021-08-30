import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebend/common/alert_action_sheet.dart';
import 'package:ebend/constants/color_constants.dart';
import 'package:ebend/helper/utils.dart';
import 'package:ebend/main_screens/create_job/create_job_2.dart';
import 'package:ebend/stores/local_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateJob1 extends StatefulWidget {
  const CreateJob1({Key? key}) : super(key: key);

  @override
  _CreateJob1State createState() => _CreateJob1State();
}

class _CreateJob1State extends State<CreateJob1> {

  TextEditingController txtEditJobName = TextEditingController();
  TextEditingController txtEditAddress = TextEditingController();
  TextEditingController txtEditSiteContactName = TextEditingController();
  TextEditingController txtEditSiteContactNumber = TextEditingController();
  TextEditingController txtEditSiteNote = TextEditingController();

  bool validations() {
    bool valid = false;
    var strMsg = "";
    if(txtEditJobName.text.isEmpty) {
      strMsg = "Please enter job";
    } else if(txtEditAddress.text.isEmpty) {
      strMsg = "Please enter address";
    } else if(txtEditSiteContactName.text.isEmpty) {
      strMsg = "Please enter site contact name";
    } else if(txtEditSiteContactNumber.text.isEmpty) {
      strMsg = "Please select site contact number";
    } else if(txtEditSiteNote.text.isEmpty) {
      strMsg = "Please enter site note";
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
          "Create Job 1/2",
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
                controller: txtEditJobName,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Job#",
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
                controller: txtEditAddress,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Address",
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
                controller: txtEditSiteContactName,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Site Contact Name",
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
                controller: txtEditSiteContactNumber,
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
                  hintText: "Site Contact Number",
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
                controller: txtEditSiteNote,
                //minLines: 1,
                maxLines: 6,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Site Note",
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
                    if (validations()) {
                      addJob();
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

  addJob() async {
    var dict = {
      "jobName": txtEditJobName.text,
      "address": txtEditAddress.text,
      "siteContactName": txtEditSiteContactName.text,
      "siteContactNumber": txtEditSiteContactNumber.text,
      "siteNote": txtEditSiteNote.text
    };
      CollectionReference users =
      FirebaseFirestore.instance.collection("users");
      var info = await LocalStore.getUserInfo();
      return users.doc(info.uid).collection("job").add(dict).then((value) {
        print(value.id);
        users.doc(info.uid).collection("job").doc(value.id).update({"id": value.id}).then((val)  {
          Utils.push(context, CreateJob2(jobId: value.id,));
        });
      }).catchError((error) {
        AlertActionSheet.showAlert(
            context, "Alert!", error.toString(), ["Ok"], (index) {});
      });
  }
}
