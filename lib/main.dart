import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_viewer/app/models/hive/pdf_data_model.dart';
import 'app/API/box_provider.dart';

const pdfData =
    "pdfData"; //  TODO: move to provider & need additional box for current loaded

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PdfDataModelAdapter());
  await Hive.openBox<PdfDataModel>(BoxProvider.previouslyViewedFiles);
  await Hive.openBox<PdfDataModel>(BoxProvider.currentViewBox);
  runApp(const PDFViewerApp());
}

//  TODO: close box on dispose, find right opportunity
