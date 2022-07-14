import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_viewer/app/API/previous_vieweed_box_provider.dart';
import 'package:pdf_viewer/app/API/selected_box_provider.dart';
import 'package:pdf_viewer/app/models/hive/pdf_data_model.dart';
import 'package:pdf_viewer/app/widgets/app_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf_viewer/app/widgets/list_placeholder_page.dart';
import 'package:date_format/date_format.dart';
import 'package:provider/provider.dart';

import '../models/pdfFileModel.dart';

class PdfList extends StatelessWidget {
  const PdfList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<PreviousViewedBoxProvider>().getListOfFiles();
    void onClickLaunchFilePicker() async {
      List<PDFFileModel>? result = await getPlatformFile();
      if (result == null) return;

      selectedBoxProvider.addFilesToSelectedBox(files: result);

      //PDFFileModel f = PDFFileModel(file: result.file, title: result.title);
      if (result.length > 1) {
        Navigator.of(context).pushNamed("/multiFileSelected");
      } else {
        Navigator.of(context).pushNamed("/viewer", arguments: result.first);
      }

      Provider.of<PreviousViewedBoxProvider>(context, listen: false)
          .addFilesToBox(files: result);
    }

    void clearEntireList() {
      context.read<PreviousViewedBoxProvider>().clearEntireBox();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF LIST"),
        actions: [
          IconButton(
              onPressed: onClickLaunchFilePicker, icon: const Icon(Icons.add)),
          IconButton(
              onPressed: clearEntireList, icon: const Icon(Icons.clear_all)),
        ],
      ),
      body: Consumer<PreviousViewedBoxProvider>(
        builder: (context, box, _) {
          if (box.getFiles.isEmpty) {
            return ListPlaceholderPage(
                openFileBrowser: onClickLaunchFilePicker);
          }
          return ListView.builder(
              itemCount: box.getFiles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(box.getFiles[index].fileName),
                );
              });
        },
      ),
    );
  }
}

// if error loading, display error
// if > 1, ??? maybe open modal, display files || load first file and have navigation to other files

Future<List<PDFFileModel>?> getPlatformFile() async {
  await clearSelectedBox;
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
