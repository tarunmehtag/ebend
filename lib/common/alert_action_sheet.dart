import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertActionSheet {

  static showAlert(BuildContext context, String title, String content, List<String> actions, Function(int) completion, {String cancelActionText = ""}) {
    List<CupertinoDialogAction> arrayActions = [];
    for(int i = 0; i < actions.length; i++) {
      arrayActions.add(CupertinoDialogAction(
        child: Text(actions[i]),
        onPressed: () {
          Navigator.of(context).pop(true);
          completion(i);
        },
      ));
    }
    if (cancelActionText != "")
      arrayActions.add(CupertinoDialogAction(
        child: Text(cancelActionText),
        onPressed: () => Navigator.of(context).pop(false),
      ));
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: arrayActions,
      ),
    );
  }

  static showActionSheet(BuildContext context, String title, String message, List<String> actions, Function(int) completion) {
    List<CupertinoActionSheetAction> arrayActions = [];
    for(int i = 0; i < actions.length; i++) {
      arrayActions.add(CupertinoActionSheetAction(
        child: Text(actions[i]),
        isDestructiveAction: false,
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context);
          completion(i);
        },
      ));
    }
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(
          title,
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        message: Text(
          message,
          style: TextStyle(fontSize: 15.0, color: Colors.black),
        ),
        actions: arrayActions,
        cancelButton: CupertinoActionSheetAction(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}