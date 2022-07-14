import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/API/previous_vieweed_box_provider.dart';
import 'package:pdf_viewer/app/routes.dart';
import 'package:provider/provider.dart';

class PDFViewerApp extends StatelessWidget {
  const PDFViewerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PDF Viewer",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: "/",
      onGenerateRoute: _routes,

    );
  }
}

Route _routes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case "/":
      return getListView(settings: routeSettings);
    case "/viewer":
      return getPDFViewer(settings: routeSettings);
    case "/multiFileSelected":
      return getMultiFileSelectedView(settings: routeSettings);
    default:
      return getListView(settings: routeSettings);
  }
}
