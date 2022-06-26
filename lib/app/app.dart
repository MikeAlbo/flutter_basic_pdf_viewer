import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/screens/pdf_list.dart';

class PDFViewerApp extends StatelessWidget {
  const PDFViewerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PDF Viewer",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const PdfList(),
    );
  }
}
