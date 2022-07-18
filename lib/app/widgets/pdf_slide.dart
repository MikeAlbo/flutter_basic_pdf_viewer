import 'package:flutter/material.dart';

import 'package:pdf_viewer/app/helpers/string_helpers.dart';
import 'package:pdf_viewer/app/models/hive/pdf_data_model.dart';

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
