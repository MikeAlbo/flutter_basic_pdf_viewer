import 'package:flutter/material.dart';

AppBar buildAppBar(
    {required String title,
    bool centerTitle = true,
    List<Widget>? actions,
    required BuildContext context}) {
  return AppBar(
    backgroundColor: Theme.of(context).canvasColor,
    elevation: 1.0,
    shadowColor: Colors.lightBlue,
    //actionsIconTheme: const IconThemeData(color: Colors.black87),
    iconTheme: const IconThemeData(color: Colors.black87),
    centerTitle: centerTitle,
    title: Text(
      title,
      style: const TextStyle(color: Colors.black87),
    ),
    actions: actions,
  );
}
