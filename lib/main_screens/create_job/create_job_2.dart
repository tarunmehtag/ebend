import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebend/constants/color_constants.dart';
import 'package:ebend/helper/utils.dart';
import 'package:ebend/main_screens/create_order/create_order_1.dart';
import 'package:ebend/models/job_model.dart';
import 'package:ebend/models/order_model.dart';
import 'package:ebend/models/user_model.dart';
import 'package:ebend/stores/local_store.dart';
import 'package:flutter/material.dart';

class CreateJob2 extends StatefulWidget {

  final String jobId;

  const CreateJob2({Key? key, this.jobId = ''}) : super(key: key);

  @override
  _CreateJob2State createState() => _CreateJob2State();
}

class _CreateJob2State extends State<CreateJob2> {

  List<Map<String, String>> arrayInfo = [
    {"title": "Footing", "date": "01-07-2021", "status": "Received"},
    {"title": "Block Walls", "date": "20-06-2021", "status": "Draft"},
    {"title": "Rw Footing", "date": "05-07-2021", "status": "Sent"}
  ];

  var orderStream;// = FirebaseFirestore.instance.collection('users').doc(info.id).collection("job").snapshots();
  //List<JobModel> arrayForDelete = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    UserModel userInfo = await LocalStore.getUserInfo();
    orderStream = FirebaseFirestore.instance.collection('users').doc(userInfo.uid).collection("job").doc(widget.jobId).collection("order").snapshots();
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
          "Create Job 2/2",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.0,
          ),
          Expanded(
            child: orderStream == null ? FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Utils.push(context, CreateOrder1(jobId: widget.jobId,));
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
                      Text(" Add Order",
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
            ) : StreamBuilder<QuerySnapshot>(
                stream: orderStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading...");
                  }
                  return ListView.builder(
                      itemCount: snapshot.data == null ? 1 : snapshot.data!.docs.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return FlatButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Utils.push(context, CreateOrder1(jobId: widget.jobId,));
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
                                  Text(" Add Order",
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
                      var model = OrderModel.fromJson(data);
                      return Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: (MediaQuery.of(context).size.width-40)/3,
                                child: Center(
                                  child: Text(model.orderName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: (MediaQuery.of(context).size.width-40)/3,
                                child: Center(
                                  child: Text(model.dateOrder,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: (MediaQuery.of(context).size.width-40)/3,
                                child: Center(
                                  child: Text("",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
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
                    print("Delete pressed.");
                  },
                  child: Text(
                    "CREATE JOB",
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
