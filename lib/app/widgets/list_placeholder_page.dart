import 'package:flutter/material.dart';

class ListPlaceholderPage extends StatelessWidget {
  final VoidCallback openFileBrowser;
  const ListPlaceholderPage({Key? key, required this.openFileBrowser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No PDF files yet!", style: Theme.of(context).textTheme.displaySmall),
        const Divider(height: 20.0,),
        Text("to view files, open the file browser below!", style: Theme.of(context).textTheme.subtitle1,),
        const Divider(height: 20.0,),
        IconButton(onPressed: openFileBrowser, icon: Icon(Icons.add_circle_outline, color: Colors.red[300], size: 50.0,)),
      ],
    );
  }
}


//  TODO: define a text theme file, move all inline theming to file