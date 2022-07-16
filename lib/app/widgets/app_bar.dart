import 'package:flutter/material.dart';

AppBar buildAppBar(
    {required String title,
    bool centerTitle = true,
    List<Widget>? actions,
    required BuildContext context}) {
  return AppBar(
    backgroundColor: Theme.of(context).canvasColor,
    elevation: 0.5,
    shadowColor: Colors.blueGrey,
    actionsIconTheme: IconThemeData(color: Colors.black87),
    centerTitle: centerTitle,
    title: Text(
      title,
      style: TextStyle(color: Colors.black87),
    ),
    actions: actions,
  );
}
