import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/screens/pdf_list.dart';
import 'package:pdf_viewer/app/screens/pdf_viewer.dart';

Route getListView({required RouteSettings settings}){
  return MaterialPageRoute(builder: (BuildContext context){
    return const PdfList();
  });
}

Route getPDFViewer({required RouteSettings settings}){
  return MaterialPageRoute(builder: (BuildContext context){
    return const PDFViewer();
  });
}