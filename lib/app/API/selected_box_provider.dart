//  TODO: hive methods to read and write from the object store
//  TODO: interface with the app to get
//  TODO: -- the current file being used
//  TODO: -- the most recent viewed
//  TODO: -- all files, sort functions
//  TODO: -- favorite files
//  TODO: put new file
//  TODO: update file (saved)
//  TODO: delete file (swiped to remove/ no longer available)
//  TODO: on error handling

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/hive/pdf_data_model.dart';
import '../models/pdf_file_model.dart';

class SelectedBoxProvider {
  static const String selectedViewBox = "currentViewBox";

//  static const String previouslyViewedFiles = "previouslyViewedFiles";

// connect to hive box
  static Box<PdfDataModel> _selectedViewBox() =>
      Hive.box<PdfDataModel>(selectedViewBox);

  Box<PdfDataModel> get getSelectedViewBox => _selectedViewBox();

// add selected files to box (temp storage)
  void addFilesToSelectedBox({required List<PDFFileModel> files}) async {
    for (var file in files) {
      PdfDataModel fileData = PdfDataModel(
          fileName: file.title!,
          path: file.file.path,
          pinned: false,
          addDate: DateTime.now(),
          lastViewedDate: DateTime.now());
      await _selectedViewBox().add(fileData);
    }
  }

  // get the list of files from the currentViewBox
  List<PdfDataModel> getFilesFromCurrent() {
    return _selectedViewBox().values.toList();
  }

  // get a single item by key
  PdfDataModel? getItem({required int key}) {
    return _selectedViewBox().get(key);
  }

// remove all files from box (upon dispose / called when new files selected)
  void _removeFilesFromBox() => _selectedViewBox().clear();

// dispose hive box
}

// get method to return class instance
SelectedBoxProvider _selectedBoxProvider = SelectedBoxProvider();

SelectedBoxProvider get selectedBoxProvider => _selectedBoxProvider;

get clearSelectedBox => _selectedBoxProvider._removeFilesFromBox();
