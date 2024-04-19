class ModalityEntity {
  final String acronym;
  final String name;
  final int minLength;
  final int maxLength;
  final int maxValue;
  final List<String> details;
  final bool isCaixa;
  final bool isGroup;
  final List<String> listeds;

  ModalityEntity({
    required this.acronym,
    required this.name,
    required this.minLength,
    required this.maxLength,
    required this.maxValue,
    required this.details,
    required this.isCaixa,
    required this.isGroup,
    required this.listeds,
  });
}
