import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebend/constants/color_constants.dart';
import 'package:ebend/helper/utils.dart';
import 'package:ebend/main_screens/add_member/add_member.dart';
import 'package:ebend/models/member_model.dart';
import 'package:ebend/models/user_model.dart';
import 'package:ebend/stores/local_store.dart';
import 'package:flutter/material.dart';

class CreateOrder2 extends StatefulWidget {

  final String orderId;
  final String jobId;

  const CreateOrder2({Key? key, this.orderId = '', this.jobId = ''}) : super(key: key);

  @override
  _CreateOrder2State createState() => _CreateOrder2State();
}

class _CreateOrder2State extends State<CreateOrder2> {

  List<Map<String, String>> arrayInfo = [
    {"title": "SF1", "date": "01-07-2021", "status": "Received"},
    {"title": "RW1", "date": "20-06-2021", "status": "Draft"},
    {"title": "RW2", "date": "05-07-2021", "status": "Sent"}
  ];

  var memberStream;// = FirebaseFirestore.instance.collection('users').doc(info.id).collection("job").snapshots();
  //List<JobModel> arrayForDelete = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    UserModel userInfo  = await LocalStore.getUserInfo();
    memberStream = FirebaseFirestore.instance.collection('users').doc(userInfo.uid).collection("job").doc(widget.jobId).collection("order").doc(widget.orderId).collection("member").snapshots();
    setState(() {
      print(userInfo);
    });
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
          "Create Order 2/2",
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
              "Manage",
              style: TextStyle(color: ColorConstants.mainColor),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.0,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: memberStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading...");
              }
              return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return FlatButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Utils.push(context, AddMember(jobId: widget.jobId, orderId: widget.orderId,));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_circle_outline, color: ColorConstants.mainColor,),
                                  Text(" Add Member",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      Map<String, dynamic> data = snapshot.data!.docs[index-1].data() as Map<String, dynamic>;
                      var model = MemberModel.fromJson(data);
                      return Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Container(
                            width: (MediaQuery.of(context).size.width-40),
                            child: Center(
                              child: Text(model.memberName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }
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
                    print("Delete pressed.");
                    Navigator.of(context).popUntil((route){
                      return route.settings.name == 'HomeScreen';
                    });
                  },
                  child: Text(
                    "SEND ORDER",
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
}
