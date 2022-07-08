import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/models/hive/pdf_data_model.dart';

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
    return Container(
      color: Colors.amber,
      child: Text(widget.pdfDataModel.fileName),
    );
  }
}

//  TODO: slide should have a caption (file name or page number
//  TODO: container should be a fixed size, no matter the size of the image/ page
//  TODO: should have a placeholder text/ icon if the image/ page can not load
//  TODO: should have an icon showing the number of pages in the document
//  TODO: should have a loading icon while the data is loading
//  TODO: optional swipe to remove

//  TODO: possible 2 approaches:
//    the data is loading in a service and a PdfSlide is generated each time new data is retrieved
//    or - (the way I'm trying it first)
// 1. SQL call to get list of files to be loaded
// 2. an PdfSlide is created for each item retrieved
// 3. if loading error (file moved or deleted) - file missing showed, option to remove
// 4. if unable to generate first page - placeholder text
// 5. after new PdfSlide created, add it to a list view
// 6. swipe to clear file from cache
// 7. possible "delete" function, remove from device
// 8. clickable, to allow navigation to viewer
