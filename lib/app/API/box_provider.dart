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
import '../models/hive/pdf_data_model.dart';
import '../models/pdfFileModel.dart';

enum BoxType { currentView, previouslyViewed }

class BoxProvider {
  static const String currentViewBox = "currentViewBox";
  static const String previouslyViewedFiles = "previouslyViewedFiles";

// connect to hive box
  static Box<PdfDataModel> _currentViewBox() =>
      Hive.box<PdfDataModel>(currentViewBox);

  static Box<PdfDataModel> _previousViewBox() =>
      Hive.box<PdfDataModel>(previouslyViewedFiles);

  Box<PdfDataModel> get getPreviousViewBox => _previousViewBox();

  Box<PdfDataModel> get getCurrentViewBox => _currentViewBox();

// add selected files to box (temp storage)
  void addFilesToLocalStorage(
      {required List<PDFFileModel> files, required BoxType box}) async {
    for (var file in files) {
      PdfDataModel fileData = PdfDataModel()
        ..path = file.file.path
        ..fileName = file.title!
        ..pinned = false
        ..addDate = DateTime.now()
        ..lastViewedDate = DateTime.now();
      box == BoxType.currentView
          ? await _currentViewBox().add(fileData)
          : await _previousViewBox().add(fileData);
    }
  }

  // get the list of files from the currentViewBox
  List<PdfDataModel> getFilesFromCurrent() {
    return _currentViewBox().values.toList();
  }

// remove a single file from box (UI control)

// remove all files from box (upon dispose / called when new files selected)
  void removeFilesFromBox({required BoxType boxType}) {
    boxType == BoxType.currentView
        ? _currentViewBox().clear()
        : _previousViewBox().clear();
  }

// dispose hive box
}

// get method to return class instance
BoxProvider _boxProvider = BoxProvider();

BoxProvider get getBoxProvider => _boxProvider;
