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
import 'dart:collection';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_viewer/app/API/selected_box_provider.dart';
import 'package:pdf_viewer/app/models/pdfFileModel.dart';

import '../models/hive/pdf_data_model.dart';

bool checkForValidPath({required String path}) {
  //  TODO: move to helper file
  return File(path).isAbsolute;
  //return await File(path).exists();
}

class PreviousViewedBoxProvider extends ChangeNotifier {
  static const String previousViewBox = "PreviousViewBox";

  // static Box<PdfDataModel> _previousViewBox() =>
  //     Hive.box<PdfDataModel>(previousViewBox);

  List<PdfDataModel> _fileList = [];

  List<PdfDataModel> get getFiles => _fileList;

  //List<PdfDataModel> get getFiles => _fileList;

  PreviousViewedBoxProvider() {
    //getListOfFiles();
  }

  // will call all of the functions used to build a list and sort
  void getListOfFiles() {
    Box<PdfDataModel> box = Hive.box<PdfDataModel>(previousViewBox);
    _fileList = box.values.toList();
    print("get list of files: ${_fileList.length}");
    // notifyListeners();
    //ox.close();
  }

  void addFilesToBox({required List<PDFFileModel> files}) async {
    //await Hive.openBox<PdfDataModel>(previousViewBox);
    Box<PdfDataModel> box = Hive.box<PdfDataModel>(previousViewBox);

    for (var file in files) {
      PdfDataModel model = PdfDataModel(
          fileName: file.title!,
          //  TODO: refactor, same as selected
          path: file.file.path,
          pinned: false,
          addDate: DateTime.now(),
          lastViewedDate: DateTime.now());
      //_previousViewBox().add(model);
      print("add file: ${model.fileName}");
      box.add(model);
    }
    notifyListeners();
  }

  void clearEntireBox() {
    // for dev purpose, used to clear out entire list without warning
    Box<PdfDataModel> box = Hive.box<PdfDataModel>(previousViewBox);
    box.clear();
    print("clear called");
    notifyListeners();
  }
}

//  TODO: refactor - create model outside of box
//  TODO: refactor - remove usage of PDFFileModel, use only PdfDataModel
