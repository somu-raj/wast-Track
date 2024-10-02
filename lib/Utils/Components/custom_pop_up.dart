import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> popUp(
    {required String title,
    required BuildContext context,
    List<Widget> actions = const <Widget>[],
    Widget? content}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: CupertinoAlertDialog(
                title: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
                content: content,
                actions: actions),
          ));
}
