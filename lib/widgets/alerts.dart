import 'package:flutter/material.dart';

class Alerts {
  showAlert(BuildContext context, bool isEdit) {
    AlertDialog alert;
    if (isEdit) {
      alert = AlertDialog(
        title: Text("Cancel Edit?"),
        content: Text(
            "Are you sure you want to cancel this edit? Your changes will not be saved."),
        actions: [
          TextButton(
            child: Text(
              "CANCEL",
              style: TextStyle(color: Colors.grey),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
            ),
            // padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'CONFIRM',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop("Cancelled Edit");
            },
          ),
        ],
      );
    } else {
      alert = AlertDialog(
        title: Text("Cancel Entry?"),
        content: Text(
            "Are you sure you want to cancel this entry? Nothing will be saved."),
        actions: [
          TextButton(
            child: Text(
              "CANCEL",
              style: TextStyle(color: Colors.grey),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
            ),
            // padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'CONFIRM',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop("Cancelled Entry");
            },
          ),

          // TextButton(
          //   child: Text("Confirm"),
          //   onPressed:  () {
          //     Navigator.of(context).pop();
          //     Navigator.of(context).pop("Cancelled Entry");
          //   },
          // ),
        ],
      );
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
