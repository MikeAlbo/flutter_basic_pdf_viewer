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
      throw Exception("List of files is MT");
    }
    List<String> paths = files.map((e) => e.path).toList();
    List<String> names =
        files.map((e) => e.fileName.trimText(len: 15, suffix: "pdf")).toList();
    String msgSubject = buildCustomMessage(customMessage, names: names);

    await Share.shareFilesWithResult(paths,
            subject: msgSubject,
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size)
        .then((value) {
      if (value.status == ShareResultStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(buildCustomMessage("These files were shared! : ",
                names: names)),
          ),
        );
      }
    });
  } catch (e) {
    print(e);
  }
}

String buildCustomMessage(String? customMessage,
    {required List<String> names}) {
  return "${customMessage ?? "Here are the PDF files: "} ${names.length < 2 ? names.first : names.join(", ")} ";
}
