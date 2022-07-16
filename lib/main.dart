import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/API/previous_viewed_box_provider.dart';
import 'package:pdf_viewer/app/app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_viewer/app/models/hive/pdf_data_model.dart';
import 'package:provider/provider.dart';
import 'app/API/selected_box_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PdfDataModelAdapter());
  await Hive.openBox<PdfDataModel>(SelectedBoxProvider.selectedViewBox);
  await Hive.openBox<PdfDataModel>(PreviousViewedBoxProvider.previousViewBox);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => PreviousViewedBoxProvider()),
  ], child: const PDFViewerApp()));
}

//  TODO: close box on dispose, find right opportunity
