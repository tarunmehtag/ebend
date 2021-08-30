import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebend/common/alert_action_sheet.dart';
import 'package:ebend/constants/color_constants.dart';
import 'package:ebend/helper/utils.dart';
import 'package:ebend/main_screens/create_order/create_order_2.dart';
import 'package:ebend/stores/local_store.dart';
import 'package:flutter/material.dart';

class CreateOrder1 extends StatefulWidget {

  final String jobId;

  const CreateOrder1({Key? key, this.jobId = ''}) : super(key: key);

  @override
  _CreateOrder1State createState() => _CreateOrder1State();
}

class _CreateOrder1State extends State<CreateOrder1> {

  TextEditingController txtEditOrderName = TextEditingController();
  TextEditingController txtEditDateOrder = TextEditingController();
  TextEditingController txtEditDateRequiredSite = TextEditingController();
  TextEditingController txtEditOrderNote = TextEditingController();

  bool validations() {
    bool valid = false;
    var strMsg = "";
    if(txtEditOrderName.text.isEmpty) {
      strMsg = "Please enter order name";
    } else if(txtEditDateOrder.text.isEmpty) {
      strMsg = "Please select date order";
    } else if(txtEditDateRequiredSite.text.isEmpty) {
      strMsg = "Please select date required to site";
    } else if(txtEditOrderNote.text.isEmpty) {
      strMsg = "Please enter order note";
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
          "Create Order 1/2",
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
              "Edit",
              style: TextStyle(color: ColorConstants.mainColor),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: TextFormField(
                    controller: txtEditOrderName,
                    textAlign: TextAlign.center,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Order Name",
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
                    controller: txtEditDateOrder,
                    textAlign: TextAlign.center,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Date Order",
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
                    controller: txtEditDateRequiredSite,
                    textAlign: TextAlign.center,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Date Required To Site",
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
                    //minLines: 1,
                    controller: txtEditOrderNote,
                    maxLines: 6,
                    textAlign: TextAlign.center,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Order Note",
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
                          addOrder();
                        }
                      },
                      child: Text(
                        "ADD MEMBER",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),


          // widgetMember("1"),
          // widgetMember("2"),
          // widgetMember("3")
        ],
      ),
    );
  }

  addOrder() async {
    var dict = {
      "orderName": txtEditOrderName.text,
      "dateOrder": txtEditDateOrder.text,
      "dateRequiredToSite": txtEditDateRequiredSite.text,
      "orderNote": txtEditOrderNote.text,
      "jobId": widget.jobId
    };
    CollectionReference users =
    FirebaseFirestore.instance.collection("users");
    var info = await LocalStore.getUserInfo();
    return users.doc(info.uid).collection("job").doc(widget.jobId).collection('order').add(dict).then((value) {
      print(value);
      users.doc(info.uid).collection("job").doc(widget.jobId).collection('order').doc(value.id).update({"id": value.id}).then((val)  {
        Utils.push(context, CreateOrder2(orderId: value.id, jobId: widget.jobId,));
      });
    }).catchError((error) {
      AlertActionSheet.showAlert(
          context, "Alert!", error.toString(), ["Ok"], (index) {});
    });
  }

  Widget widgetMember(String number) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: ColorConstants.mainColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Text(
              "Member " + (number),
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
