
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebend/common/alert_action_sheet.dart';
import 'package:ebend/constants/color_constants.dart';
import 'package:ebend/helper/utils.dart';
import 'package:ebend/main_screens/manage_jobs.dart';
import 'package:ebend/main_screens/suppliers/suppliers_screen.dart';
import 'package:ebend/models/job_model.dart';
import 'package:ebend/models/user_model.dart';
import 'package:ebend/stores/local_store.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.uid = ''}) : super(key: key);

  final String uid;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var jobStream;// = FirebaseFirestore.instance.collection('users').doc(info.id).collection("job").snapshots();
  UserModel userInfo = UserModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    //userInfo = await LocalStore.getUserInfo();
    jobStream = FirebaseFirestore.instance.collection('users').doc(widget.uid).collection("job").snapshots();
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
        title: Row(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Utils.push(context, SuppliersScreen());
              },
              child: Text(
                "Manage Suppliers",
                style: TextStyle(color: ColorConstants.mainColor),
              ),
            ),
            Spacer(),
            Spacer(),
            Text(
              "Home",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Spacer(),
            Spacer(),
            Spacer(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return ManageJobs(uid: widget.uid,);
              },
                settings: RouteSettings(name: 'HomeScreen',),
              ));
              //Utils.push(context, ManageJobs(uid: widget.uid,));
            },
            child: Text(
              "Manage Jobs",
              style: TextStyle(color: ColorConstants.mainColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Text(
                  "Welcome " + userInfo.name + ',',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: jobStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading...");
                  }
                  print(snapshot.data!.docs.length);
                  print("************");
                  return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index){
                          Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                          var model = JobModel.fromJson(data);
                        return Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Center(child: Text(/*"Job ${index+1}"*/model.jobName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                                fontSize: 18.0,
                              ),
                            )),
                          ),
                        );
                      });
                }
              ),
            )
          ],
        ),
      ),
    );
  }

}
