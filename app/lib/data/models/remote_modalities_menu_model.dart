import './/domain/entities/entities.dart';

class RemoteModalityModel {
  final String acronym;
  final String name;
  final int minLength;
  final int maxLength;
  final int maxvalue;
  final List<String> subs;
  final bool isCaixa;
  final bool isGroup;
  final List<String> listeds;

  RemoteModalityModel({
    required this.acronym,
    required this.name,
    required this.minLength,
    required this.maxLength,
    required this.maxvalue,
    required this.subs,
    required this.isCaixa,
    required this.isGroup,
    required this.listeds,
  });

  factory RemoteModalityModel.fromMap(Map<String, dynamic> map) =>
      RemoteModalityModel(
        acronym: map['acronym'],
        name: map['name'],
        minLength: map['min_length'],
        maxLength: map['max_length'],
        maxvalue: map['max_value'],
        subs: List<String>.from(map['subs']),
        isCaixa: map['is_caixa'],
        isGroup: map['is_group'],
        listeds: List<String>.from(map['listeds']),
      );

  Map<String, dynamic> toMap() => {
        'acronym': acronym,
        'name': name,
        'min_size': minLength,
        'max_size': maxLength,
        'subs': subs,
        'is_caixa': isCaixa,
        'is_group': isGroup,
        'listeds': listeds,
      };

  ModalityEntity toEntity() => ModalityEntity(
        acronym: acronym,
        name: name,
        minLength: minLength,
        maxLength: maxLength,
        maxValue: maxvalue,
        details: subs,
        isCaixa: isCaixa,
        isGroup: isGroup,
        listeds: listeds,
      );
}
