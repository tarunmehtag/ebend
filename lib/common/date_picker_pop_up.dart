import 'package:ebend/constants/color_constants.dart';
import 'package:ebend/helper/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'date_converter.dart';

class DatePickerPopUp {

  static DateTime finalDateTime = DateTime.now();

  static selectDate(BuildContext context, TextEditingController txtEditController, String dateFormat) async {
    Utils.hideKeyboard(context);
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null) {
      txtEditController.text = DateConverter.dateToString(picked, dateFormat);
    }
  }

  static showCuperTinoDatePicker(BuildContext context, String dateFormat, DateTime initialDate , Function(String, String) completion) {
    Utils.hideKeyboard(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: ColorConstants.mainColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 45,
                      child: RaisedButton(
                        color: Colors.transparent,
                        elevation: 0.0,
                        onPressed: () {
                          completion(DateConverter.dateToString(finalDateTime.toLocal(), dateFormat), DateConverter.dateToString(finalDateTime.toUtc(), dateFormat));
                          Navigator.pop(context);
                        }, child: Center(
                        child: Text(
                          "Done",
                          style: TextStyle(
                              fontSize: 17.0, color: Colors.white),
                        ),
                      ),),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200.0,
                color: Colors.white,
                child: CupertinoDatePicker(
                  minimumDate: initialDate.subtract(Duration(days: 36500)),
                  maximumDate: DateTime.now().subtract(Duration(days: 3650)),
                  minuteInterval: 1,
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initialDate.subtract(Duration(days: 3650)),
                  onDateTimeChanged: (DateTime dateTime) {
                    finalDateTime = dateTime;
                  },
                ),
              ),
            ],
          );
        }
    );
  }

}