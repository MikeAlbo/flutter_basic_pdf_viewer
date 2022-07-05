import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/app.dart';
import 'package:hive_flutter/hive_flutter.dart';

const pdfFilesBox = "pdfFiles";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>(pdfFilesBox);
  runApp(const PDFViewerApp());
}
