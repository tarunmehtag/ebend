import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebend/constants/color_constants.dart';
import 'package:ebend/helper/utils.dart';
import 'package:ebend/main_screens/create_job/create_job_1.dart';
import 'package:ebend/models/job_model.dart';
import 'package:ebend/models/user_model.dart';
import 'package:ebend/stores/local_store.dart';
import 'package:flutter/material.dart';

class ManageJobs extends StatefulWidget {
  final String uid;

  const ManageJobs({Key? key, this.uid = ''}) : super(key: key);

  @override
  _ManageJobsState createState() => _ManageJobsState();
}

class _ManageJobsState extends State<ManageJobs> {

  var userStream;// = FirebaseFirestore.instance.collection('users').doc(info.id).collection("job").snapshots();
  List<JobModel> arrayForDelete = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    UserModel userInfo = await LocalStore.getUserInfo();
    userStream = FirebaseFirestore.instance.collection('users').doc(widget.uid).collection("job").snapshots();
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
          icon: Icon(Icons.home, color: Colors.black,),
          onPressed: () {
            Utils.popBack(context);
          },
        ),
        title: Text(
          "Manage Job List",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Utils.push(context, CreateJob1());
            },
            child: Text(
              "Create",
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: userStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading...");
                  }
                  print(snapshot.data!.docs.length);
                  print("************");
                  print(arrayForDelete);
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index){
                        Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                        var model = JobModel.fromJson(data);
                        return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                            child: Stack(
                              children: [
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30.0, right: 30.0,),
                                    child: Center(child: Text(/*"Job ${index+1}"*/model.jobName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade600,
                                        fontSize: 18.0,
                                      ),
                                    )),
                                  ),
                                ),
                                (arrayForDelete.where((element) => element.id == model.id).length > 0) ? Positioned(
                                  right: 10.0,
                                  top: 10,
                                  bottom: 10,
                                  child: Icon(Icons.check),
                                ) : Container(),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              var isContain = arrayForDelete.where((element) => element.id == model.id);
                              if (isContain.length > 0) {
                                arrayForDelete.remove(model);
                                int selectedIndex = arrayForDelete.indexWhere((element) => element.id == model.id);
                                arrayForDelete.removeAt(selectedIndex);
                              } else {
                                arrayForDelete.add(model);
                              }
                            });

                            // if (model.isSelected) {
                            //   arrayForDelete.removeAt(index);
                            // } else {
                            //   model.isSelected = true;
                            //   arrayForDelete.add(model);
                            // }
                          },
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
                  onPressed: () async {
                    for(int i = 0; i < arrayForDelete.length; i++) {
                      FirebaseFirestore.instance.collection('users').doc(
                          widget.uid).collection("job").doc(arrayForDelete[i]
                          .id).delete().then((value) {

                      }).catchError((error) {
                        print('Delete failed: $error');
                      });
                      print("Delete pressed.");
                    }
                    arrayForDelete = [];
                  },
                  child: Text(
                    "DELETE",
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
