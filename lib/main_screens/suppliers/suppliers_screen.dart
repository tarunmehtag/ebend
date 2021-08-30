import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebend/constants/color_constants.dart';
import 'package:ebend/helper/utils.dart';
import 'package:ebend/main_screens/add_member/add_member.dart';
import 'package:ebend/main_screens/suppliers/add_supplier.dart';
import 'package:ebend/models/supplier_model.dart';
import 'package:ebend/models/user_model.dart';
import 'package:ebend/stores/local_store.dart';
import 'package:flutter/material.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({Key? key}) : super(key: key);

  @override
  _SuppliersScreenState createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {

  var supplierStream;// = FirebaseFirestore.instance.collection('users').doc(info.id).collection("job").snapshots();
  UserModel userInfo = UserModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    userInfo = await LocalStore.getUserInfo();
    supplierStream = FirebaseFirestore.instance.collection('users').doc(userInfo.uid).collection("supplier").snapshots();
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
          "Suppliers",
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: supplierStream,
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
                      itemCount: snapshot.data!.docs.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return FlatButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Utils.push(context, AddSupplier());
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
                                  Text(" Add Supplier",
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
                      var model = SupplierModel.fromJson(data);
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
                              child: Text(model.supplierName,
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
                    });
              }
            ),
          ),
        ],
      ),
    );
  }
}
