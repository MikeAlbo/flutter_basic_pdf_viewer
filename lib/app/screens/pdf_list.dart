import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/widgets/app_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf_viewer/app/widgets/list_placeholder_page.dart';

import '../models/pdfFileModel.dart';

class PdfList extends StatefulWidget {
  const PdfList({Key? key}) : super(key: key);

  @override
  State<PdfList> createState() => _PdfListState();
}

class _PdfListState extends State<PdfList> {
  @override
  Widget build(BuildContext context) {
    void onClickLaunchFilePicker() async {
      List<PDFFileModel>? result = await getPlatformFile();
      if (!mounted || result == null) return;

      //PDFFileModel f = PDFFileModel(file: result.file, title: result.title);
      if (result.length > 1) {
        // showMultiFileModal(list: result, context: context);
        for (var pdf in result) {
          print(pdf.title); //  TODO:handle multiple files
        }
      } else {
        Navigator.of(context).pushNamed("/viewer", arguments: result.first);
      }
    }

    return Scaffold(
      appBar: buildAppBar(title: "PDF List"),
      body: SafeArea(
        child: Center(
          child: ListPlaceholderPage(
            openFileBrowser: onClickLaunchFilePicker,
          ),
        ),
      ),
    );
  }
}

// if error loading, display error
// if > 1, ??? maybe open modal, display files || load first file and have navigation to other files

Future<List<PDFFileModel>?> getPlatformFile() async {
  List<String> allowedFIleTypes = ["pdf"];
  List<PDFFileModel> listOfModels;

  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedFIleTypes,
      allowMultiple: true);

  if (result == null) return null;

  listOfModels = result.files
      .map((f) => (PDFFileModel(file: File(f.path!), title: f.name)))
      .toList();

  return listOfModels;
}
