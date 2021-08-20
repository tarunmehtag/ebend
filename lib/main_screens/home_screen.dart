
import 'package:ebend/constants/color_constants.dart';
import 'package:ebend/helper/utils.dart';
import 'package:ebend/main_screens/manage_jobs.dart';
import 'package:ebend/main_screens/suppliers/suppliers_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              Utils.push(context, ManageJobs());
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
                  "Welcome Surixon,",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                  itemBuilder: (BuildContext context, int index){
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Center(child: Text("Job ${index+1}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                        fontSize: 18.0,
                      ),
                    )),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
