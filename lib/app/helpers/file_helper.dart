//  TODO: get files from platform
//  TODO: save files in application directory folder
//  TODO: create PdfFile from the information inside new dir

import 'dart:io';

import 'package:path_provider/path_provider.dart';

class SaveFiles {
  Directory? _appDir;
  final String _pdfFolder = "pdfStorage";
  String? _pdfFolderPath;

  SaveFiles() {
    _loadAppDir();
  }

  Future<void> _loadAppDir() async {
    _appDir ??= await getApplicationDocumentsDirectory();
    _pdfFolderPath = await _getPdfFolder(appDir: _appDir!);
  }

  // verify pdfFOlder exist, create if not

  Future<String> _getPdfFolder({required Directory appDir}) async {
    String fullPath = "${appDir.path}/$_pdfFolder/";
    Directory d = Directory(fullPath);
    if (!await d.exists()) {
      await d.create(recursive: true);
      return d.path;
    }
    return d.path;
  }

// add a file to the documentDirectory
  Future<File> saveFileToAppStorage(File file, String name) async {
    _appDir ??= await getApplicationDocumentsDirectory();
    _pdfFolderPath ??= await _getPdfFolder(appDir: _appDir!);
    return await file.copy("${_pdfFolderPath!}$name");
  }

// remove a file from the documentDirectory
  void removeFileFromAppStorage({required File file}) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print(e);
    }
  }

}
