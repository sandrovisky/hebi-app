import 'package:equatable/equatable.dart';

import './/presentation/protocols/protocols.dart';
import './/validation/protocols/protocols.dart';

class OnlyNumberValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  const OnlyNumberValidation(this.field);

  @override
  ValidationError? validate(Map input) {
    try {
      int.parse(input[field]);
      return null;
    } catch (e) {
      return ValidationError.onlyNumbers;
    }
  }

  @override
  List get props => [field];
}
