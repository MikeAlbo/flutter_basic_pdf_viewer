import 'package:hive/hive.dart';

part 'pdf_data_model.g.dart';

@HiveType(typeId: 0)
class PdfDataModel extends HiveObject {
  @HiveField(0)
  late String fileName;

  @HiveField(1)
  late String path;

  @HiveField(2)
  late DateTime addDate;

  @HiveField(3)
  late DateTime lastViewedDate;

  @HiveField(4)
  late bool pinned;

  PdfDataModel(
      {required this.fileName, required this.path, required this.pinned, required this.addDate, required this.lastViewedDate});
}
