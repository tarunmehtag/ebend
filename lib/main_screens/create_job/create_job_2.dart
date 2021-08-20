import 'package:ebend/constants/color_constants.dart';
import 'package:ebend/helper/utils.dart';
import 'package:ebend/main_screens/create_order/create_order_1.dart';
import 'package:flutter/material.dart';

class CreateJob2 extends StatefulWidget {
  const CreateJob2({Key? key}) : super(key: key);

  @override
  _CreateJob2State createState() => _CreateJob2State();
}

class _CreateJob2State extends State<CreateJob2> {

  List<Map<String, String>> arrayInfo = [
    {"title": "Footing", "date": "01-07-2021", "status": "Received"},
    {"title": "Block Walls", "date": "20-06-2021", "status": "Draft"},
    {"title": "Rw Footing", "date": "05-07-2021", "status": "Sent"}
  ];

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
            child: ListView.builder(
                itemCount: arrayInfo.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Utils.push(context, CreateOrder1());
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
                  Map<String, String> dict = arrayInfo[index-1];
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
                              child: Text(dict["title"] as String,
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
                              child: Text(dict["date"] as String,
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
                              child: Text(dict["status"] as String,
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
                }),
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
