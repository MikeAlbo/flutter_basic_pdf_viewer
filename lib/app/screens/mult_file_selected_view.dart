import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_viewer/app/API/selected_box_provider.dart';
import 'package:pdf_viewer/app/widgets/app_bar.dart';
import 'package:pdf_viewer/app/widgets/pdf_slide.dart';

import '../models/hive/pdf_data_model.dart';
import '../models/pdfFileModel.dart';

class MultiFileSelectedView extends StatelessWidget {
  const MultiFileSelectedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "Selected Files", actions: [
        IconButton(
            onPressed: () =>
                getBoxProvider.removeFilesFromBox(boxType: BoxType.selected),
            icon: const Icon(Icons.clear_all))
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
      valueListenable: getBoxProvider.getCurrentViewBox.listenable(),
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
