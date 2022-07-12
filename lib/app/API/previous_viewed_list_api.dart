//  TODO: load data from box
//  TODO: check to see if paths are still valid
//  TODO: sort items that are pinned in pinned list
//  TODO: enum to describe sort options
//  TODO: sort items by enum/ generate titles for sections
//  TODO: clear all function, with confirmation alert
//  TODO: stream to broadcast List to UI
//  TODO: entire list should be built in API and broadcast as whole
//  TODO: handle pinning of an item
//  TODO: handle deleting of an item
//  TODO: handle invalid item workflow

// check for valid file path
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_viewer/app/API/selected_box_provider.dart';

import '../models/hive/pdf_data_model.dart';

bool checkForValidPath({required String path}) {
  return File(path).isAbsolute;
  //return await File(path).exists();
}

class PreviouslyViewedListApi {
  //List<PdfDataModel> pdfs = getBoxProvider.getPreviousViewBox.values.toList();
  ValueListenable<Box<PdfDataModel>> pdfListener =
      getBoxProvider.getPreviousViewBox.listenable();
}
