import 'package:flutter/material.dart';

import 'package:pdf_viewer/app/screens/mult_file_selected_view.dart';
import 'package:pdf_viewer/app/screens/pdf_list.dart';
import 'package:pdf_viewer/app/screens/pdf_viewer.dart';

import 'models/pdfFileModel.dart';

Route getListView({required RouteSettings settings}) {
  return MaterialPageRoute(builder: (BuildContext context) {
    return const PdfList();
  });
}

Route getPDFViewer({required RouteSettings settings}) {
  return MaterialPageRoute(builder: (BuildContext context) {
    return PDFViewerScreen(pdfFileModel: settings.arguments as PDFFileModel);
  });
}

Route getMultiFileSelectedView({required RouteSettings settings}) {
  return MaterialPageRoute(builder: (BuildContext context) {
    return const MultiFileSelectedView();
  });
}
