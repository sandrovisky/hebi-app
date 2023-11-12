import 'package:equatable/equatable.dart';

import './/presentation/protocols/protocols.dart';
import './/validation/protocols/protocols.dart';

class CompareFieldsValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  final String fieldToCompare;

  const CompareFieldsValidation({
    required this.field,
    required this.fieldToCompare,
  });

  @override
  ValidationError? validate(Map input) => input[field] != null &&
          input[fieldToCompare] != null &&
          input[field] != input[fieldToCompare]
      ? ValidationError.invalidField
      : null;

  @override
  List get props => [field, fieldToCompare];
}
