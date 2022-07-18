import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_viewer/app/API/selected_box_provider.dart';
import 'package:pdf_viewer/app/widgets/app_bar.dart';
import 'package:pdf_viewer/app/widgets/pdf_slide.dart';

import '../models/hive/pdf_data_model.dart';
import '../models/pdf_file_model.dart';
import '../helpers/share_helper.dart';

class MultiFileSelectedView extends StatelessWidget {
  const MultiFileSelectedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void shareAllFiles(BuildContext context) {
      var b = selectedBoxProvider.getSelectedViewBox;
      final files = b.values.toList().cast<PdfDataModel>();
      shareFile(context: context, files: files);
    }

    return Scaffold(
      appBar: buildAppBar(context: context, title: "Selected Files", actions: [
        IconButton(
            onPressed: () => shareAllFiles(context),
            icon: const Icon(Icons.ios_share))
      ]),
      body: const SafeArea(
        child: ListedFiles(),
      ),
    );
  }
}

class Subtitle extends StatelessWidget {
  final String subtitle;

  const Subtitle({Key? key, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          subtitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

class ListedFiles extends StatelessWidget {
  const ListedFiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onClickNavigateTo(PdfDataModel pdf) {
      PDFFileModel fileModel =
          PDFFileModel(file: File(pdf.path), title: pdf.fileName);
      Navigator.of(context).pushNamed("/viewer", arguments: fileModel);
      // print("tapped: ${fileModel.title}, path: ${fileModel.file}");
    }

    return ValueListenableBuilder(
      valueListenable: selectedBoxProvider.getSelectedViewBox.listenable(),
      builder: (context, box, _) {
        final files = box.values.toList().cast<PdfDataModel>();
        if (files.isEmpty) {
          return const Text("No Files Selected");
        }
        return GridView.builder(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            gridDelegate: delegate,
            itemCount: files.length,
            itemBuilder: (BuildContext ctx, int index) {
              if (files.isEmpty) {
                return const Text("No Files Selected!");
              }
              return GestureDetector(
                onTap: () => onClickNavigateTo(files[index]),
                child: PdfSlide(
                  pdfDataModel: files[index],
                ),
              );
            });
      },
    );
  }
}

SliverGridDelegate delegate = const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,
    childAspectRatio: 3 / 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 15);
