// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_collection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoanCollectionAdapter extends TypeAdapter<LoanCollection> {
  @override
  final typeId = 0;

  @override
  LoanCollection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoanCollection(
      sessionId: (fields[0] as num).toInt(),
      productType: fields[1] as String,
      memberNo: fields[2] as String,
      accountNo: fields[3] as String,
      customerName: fields[4] as String,
      balance: (fields[5] as num).toDouble(),
      lastUpdateDate: fields[6] as DateTime,
      colAmt: (fields[7] as num).toDouble(),
      paymentType: fields[8] as String?,
      createdBy: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LoanCollection obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.sessionId)
      ..writeByte(1)
      ..write(obj.productType)
      ..writeByte(2)
      ..write(obj.memberNo)
      ..writeByte(3)
      ..write(obj.accountNo)
      ..writeByte(4)
      ..write(obj.customerName)
      ..writeByte(5)
      ..write(obj.balance)
      ..writeByte(6)
      ..write(obj.lastUpdateDate)
      ..writeByte(7)
      ..write(obj.colAmt)
      ..writeByte(8)
      ..write(obj.paymentType)
      ..writeByte(9)
      ..write(obj.createdBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoanCollectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
