import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/widgets/app_bar.dart';
import 'package:file_picker/file_picker.dart';

import '../models/pdfFileModel.dart';

class PdfList extends StatefulWidget {
  const PdfList({Key? key}) : super(key: key);

  @override
  State<PdfList> createState() => _PdfListState();
}

class _PdfListState extends State<PdfList> {
  File? currentFile;



  @override
  Widget build(BuildContext context) {
    
    onClickLaunchFilePicker() async{
      currentFile =  await _getFile();
      if(!mounted || currentFile == null) return;
      PDFFileModel f = PDFFileModel(file: currentFile!);
      Navigator.of(context).pushNamed("/viewer", arguments: f);
    }

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
               ElevatedButton(onPressed: onClickLaunchFilePicker, child: const Text("launch file picker")),
            ],
          ),
        ),
      ),
    );
  }
}


// prompt user for file
// if file, then navigate to viewer page
// load pdf inside viewer page
// while loading display loading icon
// display file
// if error loading, display error

// if no file, then stay on page





 Future<File?> _getFile() async{
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result == null) return null;
  return File(result.files.first.path!);
}
