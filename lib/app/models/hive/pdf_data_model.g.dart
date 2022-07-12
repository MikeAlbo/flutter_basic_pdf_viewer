// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PdfDataModelAdapter extends TypeAdapter<PdfDataModel> {
  @override
  final int typeId = 0;

  @override
  PdfDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PdfDataModel(
      fileName: fields[0] as String,
      path: fields[1] as String,
      pinned: fields[4] as bool,
      addDate: fields[2] as DateTime,
      lastViewedDate: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PdfDataModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.fileName)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.addDate)
      ..writeByte(3)
      ..write(obj.lastViewedDate)
      ..writeByte(4)
      ..write(obj.pinned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PdfDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
