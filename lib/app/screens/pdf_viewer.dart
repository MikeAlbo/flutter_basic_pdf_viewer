import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/widgets/app_bar.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

import '../models/pdf_file_model.dart';

class PDFViewerScreen extends StatefulWidget {
  final PDFFileModel pdfFileModel;

  const PDFViewerScreen({Key? key, required this.pdfFileModel})
      : super(key: key);

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    loadPDF(widget.pdfFileModel);
    super.initState();
  }

  loadPDF(PDFFileModel file) async {
    //setState(()=> _isLoading = true);
    document = await PDFDocument.fromFile(file.file);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    //loadPDF(file);
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          title:
              "PDF View:  ${_isLoading ? 'Loading...' : widget.pdfFileModel.title!}"),
      body: Center(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : PDFViewer(
                document: document,
                scrollDirection: Axis.vertical,
              ),
      ),
    );
  }
}
