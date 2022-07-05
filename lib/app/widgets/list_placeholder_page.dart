import 'package:flutter/material.dart';

class ListPlaceholderPage extends StatelessWidget {
  final VoidCallback openFileBrowser;

  const ListPlaceholderPage({Key? key, required this.openFileBrowser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No PDF files yet!",
            style: Theme.of(context).textTheme.displaySmall),
        const Divider(
          height: 10.0,
        ),
        Text(
          "to view files, open the file browser below!",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const Divider(
          height: 20.0,
        ),
        OutlinedButton(
          style: const ButtonStyle(
              elevation: MaterialStatePropertyAll(5.0),
              padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)),
              backgroundColor:
                  MaterialStatePropertyAll<Color>(Colors.lightBlue)),
          onPressed: openFileBrowser,
          child: const Icon(
            Icons.picture_as_pdf_rounded,
            color: Colors.white,
            size: 50.0,
          ),
        ),
      ],
    );
  }
}

//  TODO: define a text theme file, move all inline theming to file
