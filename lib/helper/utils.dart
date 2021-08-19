import 'package:flutter/material.dart';

class Utils {

  static push(BuildContext context, route, {completion}) async {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => route)).then((value) {
      completion(value);
    });
  }

  static popBack(BuildContext context) {
    Navigator.pop(context);
  }
}