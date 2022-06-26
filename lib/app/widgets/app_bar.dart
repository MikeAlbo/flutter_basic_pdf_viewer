import 'package:flutter/material.dart';

AppBar buildAppBar({
  required String title,
  bool centerTitle = true,
  List<Widget>? actions}){
  return AppBar(
    elevation: 1.0,
    centerTitle: centerTitle,
    title: Text(title),
    actions: actions,
  );
}