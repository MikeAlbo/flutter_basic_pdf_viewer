import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  final String title;

  const ListHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: 20.0,
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }
}
