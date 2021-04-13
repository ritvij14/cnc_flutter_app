import 'package:flutter/material.dart';


class Alerts{
  showAlert(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Cancel Input?"),
      content: Text("Are you sure you want to cancel this entry? Nothing will be saved."),
      actions: [
        TextButton(
          child: Text("Undo"),
          onPressed:  () {
          },
        ),
        TextButton(
          child: Text("Confirm"),
          onPressed:  () {
            Navigator.of(context).pop();
            Navigator.of(context).pop("Cancelled Input");
          },
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context){
          return alert;
        }
    );
  }


}
