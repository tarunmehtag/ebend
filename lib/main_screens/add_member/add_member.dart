import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebend/common/alert_action_sheet.dart';
import 'package:ebend/constants/color_constants.dart';
import 'package:ebend/helper/utils.dart';
import 'package:ebend/main_screens/draw/draw_screen.dart';
import 'package:ebend/stores/local_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddMember extends StatefulWidget {

  final String jobId;
  final String orderId;

  const AddMember({Key? key, this.jobId='', this.orderId=''}) : super(key: key);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
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
          "Add Member",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              //Utils.push(context, ManageJobs());
            },
            child: Text(
              "Template",
              style: TextStyle(color: ColorConstants.mainColor),
            ),
          ),
        ],
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
                textAlign: TextAlign.center,
                controller: txtEditMemberName,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Member Name",
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
                controller: txtEditReoSize,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Reo Size",
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
                controller: txtEditTreatment,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Treatment",
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
                controller: txtEditQuantity,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Quantity",
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: ColorConstants.mainColor, width: 1.0)
                ),
                child: TextButton(
                  onPressed: () {
                    Utils.push(context, DrawScreen());
                  },
                  child: Text(
                    "DRAW",
                    style: TextStyle(
                      color: ColorConstants.mainColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
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
                    addMember();
                    //Utils.push(context, CreateOrder2());
                  },
                  child: Text(
                    "SAVE TO ORDER",
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

  TextEditingController txtEditMemberName = TextEditingController();
  TextEditingController txtEditReoSize = TextEditingController();
  TextEditingController txtEditTreatment = TextEditingController();
  TextEditingController txtEditQuantity = TextEditingController();

  addMember() async {
    var dict = {
      "memberName": txtEditMemberName.text,
      "reoSize": txtEditReoSize.text,
      "treatment": txtEditTreatment.text,
      "quantity": txtEditQuantity.text,
      "jobId": widget.jobId,
      "orderId": widget.orderId
    };
    CollectionReference users =
    FirebaseFirestore.instance.collection("users");
    var info = await LocalStore.getUserInfo();
    return users.doc(info.uid).collection("job").doc(widget.jobId).collection('order').doc(widget.orderId).collection('member').add(dict).then((value) {
      print(value);
      users.doc(info.uid).collection("job").doc(widget.jobId).collection('order').doc(widget.orderId).collection('member').doc(value.id).update({"id": value.id}).then((val)  {
        Utils.popBack(context);
      });
    }).catchError((error) {
      AlertActionSheet.showAlert(
          context, "Alert!", error.toString(), ["Ok"], (index) {});
    });
  }
}
