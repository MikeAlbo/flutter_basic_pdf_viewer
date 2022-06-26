import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/widgets/app_bar.dart';

class PDFViewer extends StatefulWidget {
  const PDFViewer({Key? key}) : super(key: key);

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(title: "PDF Viewer"),
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("PDF List Page"),
            TextButton(onPressed: ()=> Navigator.pop(context), child: const Text("back")),
          ],
        ),),
      ),
    );
  }
}
