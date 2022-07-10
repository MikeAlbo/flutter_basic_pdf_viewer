import 'package:pdf_render/pdf_render.dart';
import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/API/box_provider.dart';
import 'package:pdf_viewer/app/models/hive/pdf_data_model.dart';
import 'package:date_format/date_format.dart';
import 'package:path/path.dart' as p;

// A PDF slide to preview either the first page of a document or an individual page for page scroll

class PdfSlide extends StatefulWidget {
  final PdfDataModel pdfDataModel;

  const PdfSlide({Key? key, required this.pdfDataModel}) : super(key: key);

  @override
  State<PdfSlide> createState() => _PdfSlideState();
}

class _PdfSlideState extends State<PdfSlide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      //color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(child: PdfImage(pdfKey: widget.pdfDataModel.key)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.pdfDataModel.fileName,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
                Text(
                  getDirFromPath(path: widget.pdfDataModel.path),
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  "date added: ${formatDate(widget.pdfDataModel.addDate, [
                        mm,
                        "/",
                        dd,
                        "/",
                        yyyy
                      ])}",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String getDirFromPath({required String path}) {
  String d = p.basename(p.dirname(path));
  return d.substring(d.lastIndexOf(".") + 1);
}

//  TODO: slide should have a caption (file name or page number
//  TODO: container should be a fixed size, no matter the size of the image/ page
//  TODO: should have a placeholder text/ icon if the image/ page can not load
//  TODO: should have an icon showing the number of pages in the document
//  TODO: should have a loading icon while the data is loading
//  TODO: optional swipe to remove

//  TODO: possible 2 approaches:
//    the data is loading in a service and a PdfSlide is generated each time new data is retrieved
//    or - (the way I'm trying it first)
// 1. SQL call to get list of files to be loaded
// 2. an PdfSlide is created for each item retrieved
// 3. if loading error (file moved or deleted) - file missing showed, option to remove
// 4. if unable to generate first page - placeholder text
// 5. after new PdfSlide created, add it to a list view
// 6. swipe to clear file from cache
// 7. possible "delete" function, remove from device
// 8. clickable, to allow navigation to viewer

class PdfImage extends StatelessWidget {
  final int pdfKey;

  const PdfImage({Key? key, required this.pdfKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getImage(int pdfKey) async {
      PdfDocument doc;
      PdfPage page;
      PdfPageImage pageImage;
      try {
        PdfDataModel? data = getBoxProvider.getCurrentViewBox.get(pdfKey);

        if (data == null) {
          throw Error();
        }
        String path = data.path;
        doc = await PdfDocument.openFile(path);
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
      doc.dispose();
      return RawImage(
        image: pageImage.imageIfAvailable,
        fit: BoxFit.cover,
      );
    }

    return FutureBuilder(
        future: getImage(pdfKey),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          return Center(
            child: snapshot.data,
          );
        });
  }
}
