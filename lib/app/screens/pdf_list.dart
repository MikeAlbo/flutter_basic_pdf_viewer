import 'dart:io';

import 'package:flutter/material.dart';

import 'package:pdf_viewer/app/API/previous_viewed_box_provider.dart';
import 'package:pdf_viewer/app/API/selected_box_provider.dart';
import 'package:pdf_viewer/app/helpers/file_helper.dart';

import 'package:file_picker/file_picker.dart';
import 'package:pdf_viewer/app/widgets/list_placeholder_page.dart';
import 'package:provider/provider.dart';

import '../models/pdfFileModel.dart';

class PdfList extends StatelessWidget {
  const PdfList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //context.watch<PreviousViewedBoxProvider>().getListOfFiles();
    context.watch<PreviousViewedBoxProvider>().loadListItems();
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
          // return ListView.builder(
          //     itemCount: box.getFiles.length,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text(box.getFiles[index].fileName),
          //       );
          //     });
          return ListView(
            children: box.getItems,
          );
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
  List<PDFFileModel> listOfModels = [];

  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedFIleTypes,
      allowMultiple: true);

  if (result == null) return null;

  SaveFiles saveFiles = SaveFiles();

  for (var r in result.files) {
    File f = await saveFiles.saveFileToAppStorage(File(r.path!), r.name);
    listOfModels.add(PDFFileModel(file: f, title: r.name));
  }

  // listOfModels = result.files
  //     .map((f) => (PDFFileModel(
  //         file:  File(f.path!), title: f.name)))
  //     .toList();

  return listOfModels;
}
