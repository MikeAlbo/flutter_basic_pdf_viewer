import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/widgets/app_bar.dart';
import 'package:file_picker/file_picker.dart';

class PdfList extends StatefulWidget {
  const PdfList({Key? key}) : super(key: key);

  @override
  State<PdfList> createState() => _PdfListState();
}

class _PdfListState extends State<PdfList> {
  File? currentFile;

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
              }, child: const Text("test next page")),
              const ElevatedButton(onPressed: _getFile, child: Text("launch file picker")),
            ],
          ),
        ),
      ),
    );
  }
}



Future<File?> _getFile() async{
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path!);
    return file;
  } else {
    // User canceled the picker
    return null;
  }
}