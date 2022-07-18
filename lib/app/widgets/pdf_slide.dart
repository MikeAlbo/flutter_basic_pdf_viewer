import 'package:pdf_render/pdf_render.dart';
import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/API/selected_box_provider.dart';
import 'package:pdf_viewer/app/helpers/string_helpers.dart';
import 'package:pdf_viewer/app/models/hive/pdf_data_model.dart';
import 'package:date_format/date_format.dart';
import 'package:path/path.dart' as p;

import '../helpers/get_pdf_image.dart';

// A PDF slide to preview either the first page of a document or an individual page for page scroll

class PdfSlide extends StatefulWidget {
  final PdfDataModel pdfDataModel;

  const PdfSlide({Key? key, required this.pdfDataModel}) : super(key: key);

  @override
  State<PdfSlide> createState() => _PdfSlideState();
}

class _PdfSlideState extends State<PdfSlide> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(child: PdfImage(pdfModel: widget.pdfDataModel)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.pdfDataModel.fileName.trimText(suffix: "pdf"),
                softWrap: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall!,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String getDirFromPath({required String path}) {
  String d = p.basename(p.dirname(path));
  return d.substring(d.lastIndexOf(".") + 1);
}

String modifyTitle({int length = 30, required String title}) {
  return title.length > length
      ? title.replaceRange(length, title.length, "...")
      : title;
}

//  TODO: slide should have a caption (file name or page number
//  TODO: container should be a fixed size, no matter the size of the image/ page
//  TODO: should have a placeholder text/ icon if the image/ page can not load
//  TODO: should have an icon showing the number of pages in the document
//  TODO: should have a loading icon while the data is loading
//  TODO: optional swipe to remove
