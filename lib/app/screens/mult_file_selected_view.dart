import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_viewer/app/API/box_provider.dart';
import 'package:pdf_viewer/app/widgets/app_bar.dart';
import 'package:pdf_viewer/app/widgets/pdf_slide.dart';

import '../models/hive/pdf_data_model.dart';

class MultiFileSelectedView extends StatelessWidget {

  const MultiFileSelectedView({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "Selected Files", actions: [
        IconButton(
            onPressed: () =>
                getBoxProvider.removeFilesFromBox(boxType: BoxType.currentView),
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
          style: Theme
              .of(context)
              .textTheme
              .titleLarge,
        ),
      ),
    );
  }
}

class ListedFiles extends StatelessWidget {


  const ListedFiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ValueListenableBuilder(
        valueListenable: getBoxProvider.getCurrentViewBox.listenable(),
        builder: (context, box, _) {
          final files = box.values.toList().cast<PdfDataModel>();
          if (files.isEmpty) {
            return const Text("No Files Selected");
          }
          return GridView.builder(
              gridDelegate: delegate,
              itemCount: files.length,
              itemBuilder: (BuildContext ctx, int index) {
                if (files.isEmpty) {
                  return const Text("No Files Selected!");
                }
                return PdfSlide(
                  pdfDataModel: files[index],
                );
              });
        },
      ),
    );
  }
}

SliverGridDelegate delegate = const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,
    childAspectRatio: 3 / 2,
    crossAxisSpacing: 20,
    mainAxisSpacing: 20);
