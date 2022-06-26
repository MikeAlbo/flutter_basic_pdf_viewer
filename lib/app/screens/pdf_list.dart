import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/widgets/app_bar.dart';

class PdfList extends StatefulWidget {
  const PdfList({Key? key}) : super(key: key);

  @override
  State<PdfList> createState() => _PdfListState();
}

class _PdfListState extends State<PdfList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(title: "PDF List"),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("PDF List Page"),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, "/viewer");
              }, child: const Text("test next page"))
            ],
          ),
        ),
      ),
    );
  }
}
