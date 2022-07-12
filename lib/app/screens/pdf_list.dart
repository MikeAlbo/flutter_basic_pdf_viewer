import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_viewer/app/API/selected_box_provider.dart';
import 'package:pdf_viewer/app/models/hive/pdf_data_model.dart';
import 'package:pdf_viewer/app/widgets/app_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf_viewer/app/widgets/list_placeholder_page.dart';
import 'package:date_format/date_format.dart';

import '../API/selected_box_provider.dart';
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

      selectedBoxProvider.addFilesToSelectedBox(files: result);

      //PDFFileModel f = PDFFileModel(file: result.file, title: result.title);
      if (result.length > 1) {
        Navigator.of(context).pushNamed("/multiFileSelected");
      } else {
        Navigator.of(context).pushNamed("/viewer", arguments: result.first);
      }

      getBoxProvider._addFilesToLocalStorage(
          files: result, box: BoxType.previouslyViewed);
    }

    return Scaffold(
      appBar: buildAppBar(title: "PDF List", actions: [
        IconButton(
            onPressed: onClickLaunchFilePicker, icon: const Icon(Icons.add)),
        IconButton(
            onPressed: () => getBoxProvider._removeFilesFromBox(
                boxType: BoxType.previouslyViewed),
            icon: const Icon(Icons.clear_all)),
      ]),
      body: SafeArea(
        child: ValueListenableBuilder<Box<PdfDataModel>>(
          valueListenable: getBoxProvider.getPreviousViewBox.listenable(),
          builder: (context, box, _) {
            final files = box.values.toList().cast<PdfDataModel>();
            if (files.isEmpty) {
              return ListPlaceholderPage(
                  openFileBrowser: onClickLaunchFilePicker);
            }
            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ListTile(
                  title: Text(files[index].fileName),
                  subtitle: Text(formatDate(
                      files[index].lastViewedDate, [mm, "/", dd, "/", yyyy])),
                  trailing: Icon(files[index].pinned
                      ? Icons.favorite
                      : Icons.favorite_border),
                );
              },
            );
          },
        ),
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
