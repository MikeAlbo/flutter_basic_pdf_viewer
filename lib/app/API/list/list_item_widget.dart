import 'package:flutter/material.dart';
import 'package:pdf_viewer/app/helpers/get_pdf_image.dart';
import 'package:pdf_viewer/app/helpers/string_helpers.dart';
import 'package:pdf_viewer/app/models/hive/pdf_data_model.dart';
import 'package:provider/provider.dart';

import '../previous_viewed_box_provider.dart';

class ListItemWidget extends StatefulWidget {
  final bool withValidPath;
  final PdfDataModel pdfDataModel;

  const ListItemWidget(
      {Key? key, required this.pdfDataModel, required this.withValidPath})
      : super(key: key);

  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.pdfDataModel.fileName),
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      onDismissed: (direction) {
        Provider.of<PreviousViewedBoxProvider>(context, listen: false)
            .removeItemFromBox(itemKey: widget.pdfDataModel.key);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${widget.pdfDataModel.fileName} was removed.")));
      },
      child: widget.withValidPath
          ? ValidFileTile(pdfDataModel: widget.pdfDataModel)
          : InvalidFileTile(pdfDataModel: widget.pdfDataModel),
    );
  }
}

// tile for a file with a valid path
class ValidFileTile extends StatelessWidget {
  final PdfDataModel pdfDataModel;

  const ValidFileTile({Key? key, required this.pdfDataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: PdfImage(
        pdfModel: pdfDataModel,
      ),
      title: Text(trimFileTitle(title: pdfDataModel.fileName)),
      trailing: IconButton(
        icon: pdfDataModel.pinned
            ? const Icon(
                Icons.favorite,
                color: Colors.redAccent,
              )
            : const Icon(
                Icons.favorite_border,
                color: Colors.black87,
              ),
        onPressed: () {
          Provider.of<PreviousViewedBoxProvider>(context, listen: false)
              .updateItemPinned(itemKey: pdfDataModel.key);
        },
      ),
    );
  }
}

// a tile for a file with an invalid path
class InvalidFileTile extends StatelessWidget {
  final PdfDataModel pdfDataModel;

  const InvalidFileTile({Key? key, required this.pdfDataModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white10,
      title: Text(
        pdfDataModel.fileName,
        style: const TextStyle(
          color: Colors.black87,
          decoration: TextDecoration.lineThrough,
        ),
      ),
      subtitle: const Text(
        "File no longer exist at location",
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }
}
