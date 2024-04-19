import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('My Dialog'),
      content: Text('This is a dialog with a TextButton.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Do something when the TextButton is pressed
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

// To show the dialog, you can use showDialog() method
// For example:
// showDialog(
//   context: context,
//   builder: (BuildContext context) {
//     return MyDialog();
//   },
// );

