// provides the functions to sort the pdf_list page and rebuild it

import 'dart:io';
import '../../models/hive/pdf_data_model.dart';
import 'list_item_widget.dart';

bool checkForValidPath({required String path}) {
  //  TODO: move to helper file
  return File(path).isAbsolute;
  //return await File(path).exists();
}

List<ListItemWidget> buildList(List<PdfDataModel> files) {
  List<ListItemWidget> finalList = [];

  finalList = movePinnedFiles(files);
  return finalList;
}

List<ListItemWidget> movePinnedFiles(List<PdfDataModel> files) {
  List<PdfDataModel> items = [];
  for (var f in files) {
    f.pinned ? items.insert(0, f) : items.add(f);
  }
  List<ListItemWidget> tiles = [];
  tiles = items
      .map((e) => ListItemWidget(
          pdfDataModel: e, withValidPath: checkForValidPath(path: e.path)))
      .toList();
  return tiles;
}
