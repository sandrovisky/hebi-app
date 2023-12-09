import './/domain/entities/entities.dart';

class RemoteShiftModel {
  final String abbr;
  final String name;
  final String number;
  final bool flushUse;
  final double flushValue;
  final bool isCaixa;
  final List weekDays;

  RemoteShiftModel(
      {required this.abbr,
      required this.name,
      required this.number,
      required this.flushUse,
      required this.flushValue,
      required this.isCaixa,
      required this.weekDays});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'abbr': abbr,
      'name': name,
      'number': number,
      'flushUse': flushUse,
      'flushValue': flushValue,
      'isCaixa': isCaixa,
      'weekDays': weekDays,
    };
  }

  factory RemoteShiftModel.fromMap(Map<String, dynamic> map) {
    return RemoteShiftModel(
      abbr: map['abbr'] as String,
      name: map['name'] as String,
      number: map['number'] as String,
      flushUse: map['flush_use'] as bool,
      flushValue: map['flush_value'] as double,
      isCaixa: map['is_caixa'] as bool,
      weekDays: map['week_days'] as List,
    );
  }

  ShiftEntity toEntity() =>
      ShiftEntity(abbr: abbr, name: name, number: number.toString());
}
