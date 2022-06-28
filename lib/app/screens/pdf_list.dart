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

  @override
  Widget build(BuildContext context) {

    onClickLaunchFilePicker() async {
      List<PDFFileModel>? result = await getPlatformFile();
      if (!mounted || result == null) return;

      //PDFFileModel f = PDFFileModel(file: result.file, title: result.title);
      if (result.length > 1){
        for(var pdf in result){
          print(pdf.title); //  TODO:handle multiple files
        }
      }
      else {
        Navigator.of(context).pushNamed("/viewer", arguments: result.first);
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(title: "PDF List"),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "PDF List Page",
                style: TextStyle(fontSize: 60),
              ),
              const Divider(
                height: 60.0,
              ),
              ElevatedButton.icon(
                onPressed: onClickLaunchFilePicker,
                icon: const Icon(
                  Icons.picture_as_pdf,
                  color: Colors.red,
                  size: 45.0,
                ),
                label: const Text("View PDF"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
                  textStyle: const TextStyle(fontSize: 45),
                  elevation: 10.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// if error loading, display error
// if > 1, ??? maybe open modal, display files || load first file and have navigation to other files

Future<List<PDFFileModel>?> getPlatformFile()async{
  List<String> allowedFIleTypes = ["pdf"];
  List<PDFFileModel> listOfModels;

  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: allowedFIleTypes, allowMultiple: true);

  if (result == null) return null;

  listOfModels = result.files.map((f) => (PDFFileModel(file: File(f.path!), title: f.name ))).toList();

  return listOfModels;
}
