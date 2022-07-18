import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/helpers/string_helpers.dart';
import 'package:pdf_viewer/app/models/hive/pdf_data_model.dart';
import 'package:share_plus/share_plus.dart';

void shareFile(
    {required BuildContext context,
    required List<PdfDataModel> files,
    bool sendFile = true,
    String? customMessage}) async {
  final box = context.findRenderObject() as RenderBox?;

  try {
    if (files.isEmpty) {
      throw "List of files is MT";
    }
    List<String> paths = files.map((e) => e.path).toList();
    List<String> names =
        files.map((e) => trimFileTitle(title: e.fileName, len: 10)).toList();
    String msgSubject =
        "${customMessage ?? "Here are the PDF files: "} ${names.length < 2 ? names.first : names.join(", ")} ";

    await Share.shareFilesWithResult(paths,
            subject: msgSubject,
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Shared files: ${value.status}"),
        ),
      );
    });
  } catch (e) {
    print(e);
  }
}
