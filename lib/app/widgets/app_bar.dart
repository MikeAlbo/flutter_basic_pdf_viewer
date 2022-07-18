import 'package:flutter/material.dart';

AppBar buildAppBar(
    {required String title,
    bool centerTitle = true,
    List<Widget>? actions,
    required BuildContext context}) {
  return AppBar(
    backgroundColor: Colors.grey[800],
    //Theme.of(context).canvasColor,
    elevation: 3.0,
    shadowColor: Colors.lightBlue,
    //actionsIconTheme: const IconThemeData(color: Colors.black87),
    iconTheme: const IconThemeData(color: Colors.white),
    centerTitle: centerTitle,
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    actions: actions,
  );
}
