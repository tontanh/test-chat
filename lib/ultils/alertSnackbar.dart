import 'package:flutter/material.dart';

class alertSnackbar {
  alertSnackbar();
  showAlert({context,String? txt,Color? color}) {
    ScaffoldMessenger.of(context)
        .showSnackBar( SnackBar(
          content: Text('$txt'),
          backgroundColor: color,
        ))
        .closed
        .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
  }
}