import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render.dart';
import '../models/hive/pdf_data_model.dart';

class PdfImage extends StatelessWidget {
  final PdfDataModel pdfModel;

  const PdfImage({Key? key, required this.pdfModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getImage(pdfDataModel: pdfModel),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          return Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                border: Border.all(
                  width: 0.5,
                  color: Colors.black54,
                )),
            child: snapshot.data,
          );
        });
  }
}

getImage({required PdfDataModel pdfDataModel}) async {
  PdfDocument doc;
  PdfPage page;
  PdfPageImage pageImage;
  try {
    doc = await PdfDocument.openFile(pdfDataModel.path)
        .onError((error, stackTrace) => throw ("open file error $error"));
    page = await doc.getPage(1);
    pageImage = await page.render();
    await pageImage.createImageIfNotAvailable();
  } catch (e) {
    print(e);
    return const Icon(
      Icons.picture_as_pdf_rounded,
      color: Colors.redAccent,
      size: 50.0,
    );
  }

  return RawImage(
    image: pageImage.imageIfAvailable,
    fit: BoxFit.cover,
  );
}
