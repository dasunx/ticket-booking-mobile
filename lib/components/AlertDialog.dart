import 'package:flutter/material.dart';

showAlertDialog(
    BuildContext context,
    String title,
    String message,
    String submitButtonText,
    String cancelButtonText,
    Function onSubmit,
    Function onClose) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text(cancelButtonText),
    onPressed: onClose,
  );
  Widget continueButton = FlatButton(
    child: Text(submitButtonText),
    onPressed: onSubmit,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      cancelButton,
      continueButton,
    ],
  ); // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
