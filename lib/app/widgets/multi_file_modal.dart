import 'package:flutter/material.dart';
import '../models/pdf_file_model.dart';

showMultiFileModal(
    {required List<PDFFileModel> list, required BuildContext context}) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return Container(
          // height: 800,
          color: Colors.transparent,
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0, // has the effect of softening the shadow
                    spreadRadius: 0.0, // has the effect of extending the shadow
                  )
                ],
              ),
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Container(
                    color: Theme.of(context).colorScheme.background,
                    child: Text("Choose File"),
                    height: 30.0,
                    width: double.infinity,
                  ),
                  ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(list[index].title!),
                        );
                      }),
                ],
              )),
        );
      });
}

class FileCard extends StatelessWidget {
  final String title;

  const FileCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.picture_as_pdf_rounded,
              size: 35.0,
              color: Colors.redAccent,
            ),
            const Divider(
              height: 10.0,
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
