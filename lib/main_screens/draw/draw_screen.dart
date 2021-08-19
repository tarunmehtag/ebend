import 'package:ebend/helper/utils.dart';
import 'package:flutter/material.dart';

class DrawScreen extends StatefulWidget {
  const DrawScreen({Key? key}) : super(key: key);

  @override
  _DrawScreenState createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
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
          "Draw",
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
              "Save Template",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width*2/3,
              height: MediaQuery.of(context).size.width*2/3,
              child: Center(
                child: Text(
                  "In Progress",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                ),

              ),
              decoration: BoxDecoration(
                // color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: Colors.blue,
                  width: 1.0,
                )
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: TextButton(
                    onPressed: () {
                      //Utils.push(context, CreateOrder2());
                    },
                    child: Text(
                      "SAVE MEMBER",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
