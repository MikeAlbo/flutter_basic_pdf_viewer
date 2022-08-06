import 'dart:io';

import 'package:flutter/material.dart';

import 'package:pdf_viewer/app/API/previous_viewed_box_provider.dart';
import 'package:pdf_viewer/app/API/selected_box_provider.dart';
import 'package:pdf_viewer/app/helpers/file_helper.dart';

import 'package:file_picker/file_picker.dart';
import 'package:pdf_viewer/app/widgets/app_bar.dart';
import 'package:pdf_viewer/app/widgets/list_placeholder_page.dart';
import 'package:provider/provider.dart';

import '../models/pdf_file_model.dart';

//  TODO: onDismiss error! remove widget from tree before updating reference docs
//  TODO: if screen larger than phone, list should be in container 1/2 width of device (or so) seperated from background
class PdfList extends StatelessWidget {
  const PdfList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //context.watch<PreviousViewedBoxProvider>().getListOfFiles();
    context.watch<PreviousViewedBoxProvider>().loadListItems();
    void onClickLaunchFilePicker() async {
      await getPlatformFile().then((value) => {
            if (value != null)
              {
                selectedBoxProvider.addFilesToSelectedBox(files: value),
                if (value.length > 1)
                  {Navigator.of(context).pushNamed("/multiFileSelected")}
                else
                  {
                    Navigator.of(context)
                        .pushNamed("/viewer", arguments: value.first)
                  },
                Provider.of<PreviousViewedBoxProvider>(context, listen: false)
                    .addFilesToBox(files: value)
              }
          });
    }

    void clearEntireList() {
      context.read<PreviousViewedBoxProvider>().clearEntireBox();
    }

    return Scaffold(
      floatingActionButton:
          context.watch<PreviousViewedBoxProvider>().getItems.isEmpty
              ? null
              : FloatingActionButton(
                  enableFeedback: true,
                  backgroundColor: Colors.lightBlue,
                  onPressed: () => onClickLaunchFilePicker(),
                  child: const Icon(Icons.picture_as_pdf_rounded),
                ),
      appBar: buildAppBar(context: context, title: "pdf list", actions: [
        IconButton(
            onPressed: onClickLaunchFilePicker, icon: const Icon(Icons.add)),
        IconButton(
            onPressed: clearEntireList, icon: const Icon(Icons.clear_all)),
      ]),
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
            padding: const EdgeInsets.only(top: 15.0),
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

  return listOfModels;
}
